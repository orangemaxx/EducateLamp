from flask import Flask, render_template, session, redirect, request, flash, url_for
import sqlite3
import json
import hashlib

def encrypt(password):
    return hashlib.sha256(password.encode()).hexdigest()

with open("config.json", "r") as file:
    config = json.load(file)

app = Flask(__name__)
app.secret_key = config['secret_key']

database = config['db']
conn = sqlite3.connect(database)
with open("main.sql", 'r') as sqlScript:
    script = sqlScript.read()
conn.executescript(script)
conn.close()

def createConnection():
    conn = sqlite3.connect(database)
    conn.row_factory = sqlite3.Row
    conn.execute("PRAGMA foreign_keys = ON")
    return conn

def check_login(loginInfo: dict):
    with createConnection() as conn:
        cursor = conn.cursor()
        query = "SELECT * FROM 'Teachers' WHERE TeacherCode = ? AND Password = ?"
        values = (loginInfo.get('teachercode'), encrypt(loginInfo.get("password")))
        cursor.execute(query, values)
        return dict(cursor.fetchone())


@app.route("/")
def index():
    if session.get('teacherCode') is None:
        return render_template("index.html")
    else:
        return render_template("homePage.html", userInfo=session.get('userInfo'))

@app.route("/login", methods=["GET", "POST"])
def login():
    if request.method == "POST":
        loginInfo = request.form.to_dict()
        loginInfo['teachercode'] = loginInfo.get('teachercode').upper()
        userInfo = check_login(loginInfo)
        if userInfo is not None:
            session['userInfo'] = userInfo
            session['teacherCode'] = loginInfo.get('teachercode')
            return redirect(url_for('index'))
        else:
            flash("Incorrect Username Or Password")
            return redirect(url_for('login'))
    else:
        if session.get('teacherCode') is not None:
            return redirect("/")
            # pass
        with createConnection() as conn:
            cursor = conn.cursor()
            query = "SELECT * FROM TeacherTypes WHERE HideSignUp != 1 ORDER BY Priority ASC"
            cursor.execute(query)
            TeacherTypes = cursor.fetchall()
            
        return render_template("login.html", TeacherTypes=TeacherTypes)
    
    
@app.route("/register", methods=["GET", "POST"])
def register():
    if request.method == "POST":
        firstname = request.form.get("firstname")
        lastname = request.form.get("lastname")
        teachercode = request.form.get('teachercode').upper()
        teachertype= request.form.get('teachertype')
        password = encrypt(request.form.get('password'))
        try:
            with createConnection() as conn:
                cursor = conn.cursor()
                cursor.execute("INSERT INTO teachers ('FirstName', 'LastName', 'TeacherCode', 'TeacherType', 'Password') VALUES (?, ?, ?, ?, ?)", (firstname, lastname, teachercode, teachertype, password))
                conn.commit()
        except:
            flash('Teacher Code Already In Use. Please Try Again')
            return redirect("/login")
        return "hi"
    else:
        return redirect("/login")


app.run(debug=True)