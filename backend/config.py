import os

DB_HOST = os.getenv("DB_HOST", "localhost")
DB_USER = os.getenv("DB_USER", "root")
DB_PASSWORD = os.getenv("DB_PASSWORD", "password")
DB_NAME = os.getenv("DB_NAME", "todo_app")
try:
    DB_PORT = int(os.getenv("DB_PORT", "3306"))
except ValueError:
    raise ValueError("DB_PORT must be a valid integer")
