import sqlite3
from http.server import BaseHTTPRequestHandler, HTTPServer

hostName = "127.0.0.1"
serverPort = 8080

db_path = 'mydb.db'
conn = sqlite3.connect(db_path)
cursor = conn.cursor()
query = 'SELECT id FROM player;'

class MyServer(BaseHTTPRequestHandler):
    def do_GET(self):

        self.send_response(200)
        self.send_header("Content-type", "text/html")
        self.end_headers()
        self.wfile.write(bytes("HI FROM PYTHON!!!", "utf-8"))

    def log_message(self, format, *args):
        return


if __name__ == "__main__":



    # Ensure the database is in memory for a fair test
    cursor.execute('PRAGMA temp_store = MEMORY;')
    cursor.execute('PRAGMA synchronous = OFF;')
    cursor.execute('PRAGMA journal_mode = MEMORY;')

    # Warm-up: Run the query once to initialize any cache or setup
    cursor.execute(query)
    cursor.fetchall()

    webServer = HTTPServer((hostName, serverPort), MyServer)
    print("Server started http://%s:%s" % (hostName, serverPort))

    try:
        webServer.serve_forever()
    except KeyboardInterrupt:
        pass

    webServer.server_close()
    print("Server stopped.")
