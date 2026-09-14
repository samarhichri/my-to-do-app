from db import get_connection


def get_all_tasks():
    connection = get_connection()
    try:
        with connection.cursor() as cursor:
            cursor.execute(
                """
                SELECT
                    id,
                    user_id,
                    title,
                    description,
                    status,
                    created_at
                FROM tasks
                ORDER BY created_at DESC
                """
            )
            result = cursor.fetchall()
    finally:
        connection.close()


def create_task(user_id, title, description):
    connection = get_connection()
    try:
        with connection.cursor() as cursor:
            cursor.execute(
                """
                INSERT INTO tasks (user_id, title, description)
                VALUES (%s, %s, %s)
                """,
                (user_id, title, description),
            )
            task_id = cursor.lastrowid
        connection.commit()
        return task_id

    except Exception:
        connection.rollback()
        raise
    finally:
        connection.close()
