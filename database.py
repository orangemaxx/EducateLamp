import sqlite3


class db():
    def __init__(self, database):
        
    
    def select(self, columns, tablename, condition = None):
        conn = self._connect()
        cursor = conn.cursor()
        return cursor.execute("""
                        SELECT (?) FROM (?) WHERE (?)
                       """, (columns, tablename, condition))

    def query(self, query, values):
        conn = self._connect()
        cursor = conn.cursor()
        cursor.execute(query, values)
        conn.commit()
        conn.close()
        
    def _connect(self):
        return(sqlite3.connect(self.database))
        