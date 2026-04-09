import os
import time
from http.server import BaseHTTPRequestHandler, HTTPServer

import pymysql

HOST = "0.0.0.0"
PORT = int(os.environ.get("APP_PORT", "8080"))
MYSQL_HOST = os.environ.get("MYSQL_HOST", "mysql")
MYSQL_ROOT_PASSWORD = os.environ.get("MYSQL_ROOT_PASSWORD", "rootpass")
MYSQL_DB = os.environ.get("MYSQL_DB", "experiment")
RETRY_SECONDS = 3


def query_users():
    for attempt in range(1, 6):
        try:
            conn = pymysql.connect(
                host=MYSQL_HOST,
                user="root",
                password=MYSQL_ROOT_PASSWORD,
                database=MYSQL_DB,
                cursorclass=pymysql.cursors.DictCursor,
                autocommit=True,
            )
            with conn.cursor() as cursor:
                cursor.execute(
                    "SELECT id, name, email FROM users ORDER BY id;")
                return cursor.fetchall()
        except Exception as error:
            print(f"mysql connect attempt {attempt}/5 error: {error}")
            time.sleep(RETRY_SECONDS)
    return []


class SimpleHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        users = query_users()
        lines = ["Docker SQL demo", "", f"users found: {len(users)}"]
        for row in users:
            lines.append(f"{row['id']}: {row['name']} <{row['email']}>")

        body = "\n".join(lines).encode("utf-8")
        self.send_response(200)
        self.send_header("Content-Type", "text/plain; charset=utf-8")
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        self.wfile.write(body)


if __name__ == "__main__":
    server = HTTPServer((HOST, PORT), SimpleHandler)
    print(f"listening on http://{HOST}:{PORT}")
    server.serve_forever()
