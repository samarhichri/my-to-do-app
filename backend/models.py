from db import get_connection


def get_all_tasks():
    connection = get_connection()
    try:
        with connection.cursor() as cursor:
            cursor.execute("SELECT id, user_id, title, description, status, created_at FROM tasks")
            result = cursor.fetchall()
            return result
    finally:
        connection.close()


def create_task(user_id, title, description):
    connection = get_connection()
    try:
        with connection.cursor() as cursor:
            sql = """
                INSERT INTO tasks (user_id, title, description)
                VALUES (%s, %s, %s)
            """
            cursor.execute(sql, (user_id, title, description))
        connection.commit()
    finally:
        connection.close()