---
# To-Do App Backend

This is the backend API for the To-Do application. It is a simple Flask service that exposes a health check and basic task management endpoints backed by a MySQL-compatible database.

The backend is intentionally small and straightforward so it can be reused as a demo application in DevOps and platform engineering projects (containerization, CI/CD, OpenShift, monitoring, etc.).

---

## Tech Stack

- Python 3.x
- Flask(3.0.0)
- flask-cors(4.0.0)
- PyMySQL(1.1.0)
- MySQL-compatible database (`todo_app` schema)

---

## Project Structure

```text
backend/
├── app.py          # Flask application factory & entrypoint
├── config.py       # Database configuration from environment variables
├── db.py           # Database connection helper (PyMySQL)
├── models.py       # Data access functions for tasks
├── routes.py       # API routes (health check and tasks)
└── requirements.txt
```

---

## Configuration

Database connection settings are provided via environment variables and have sensible defaults for local development:

- `DB_HOST` (default: `localhost`)
- `DB_USER` (default: `root`)
- `DB_PASSWORD` (default: `password`)
- `DB_NAME` (default: `todo_app`)
- `DB_PORT` (default: `3306`)

These are defined and read in `config.py`.
When running in containers or on platforms like OpenShift, you can override these values via environment variables, ConfigMaps, and Secrets.

---

## Installation & Local Development

1. **Create and activate a virtual environment (optional but recommended):**

   ```bash
   cd backend

   python -m venv venv
   source venv/bin/activate      # on Linux/macOS
   # venv\Scripts\activate       # on Windows
   ```

2. **Install dependencies:**

   ```bash
   pip install -r requirements.txt
   ```

3. **Ensure the database is running and the schema is created:**

   - Start your MySQL-compatible database.
   - Run the `database.sql` script from the project root (see general README) to create the `todo_app` schema and seed data.

4. **Run the backend:**

   ```bash
   python app.py
   ```

   By default the app listens on:

   - Host: `0.0.0.0`
   - Port: `5000`

   So the base URL is:

   - `http://localhost:5000`

---

## Application Entry Point

With the `app.py`:

The backend:

- Instantiates the Flask app via a `create_app` factory.
- Enables CORS for all routes using `flask-cors`.
- Registers the `api` blueprint from `routes.py`.

---

## Database Access

`db.py` defines a helper to get a database connection.

`models.py` implements simple data access functions for tasks.

---

## API Endpoints

All endpoints are defined in `routes.py` under the `api` blueprint.

### Health Check

- **Method:** `GET`
- **Path:** `/health`
- **Description:** Simple health check endpoint for monitoring / readiness probes.

**Response example:**

```json
{
  "status": "ok"
}
```

---

### List Tasks

- **Method:** `GET`
- **Path:** `/tasks`
- **Description:** Returns all tasks from the `tasks` table.

**Response example:**

```json
[
  {
    "id": 1,
    "user_id": 1,
    "title": "Buy milk",
    "description": "Go to supermarket to buy milk",
    "status": "pending",
    "created_at": "2024-01-01T10:00:00"
  },
  {
    "id": 2,
    "user_id": 2,
    "title": "Finish report",
    "description": "Complete project report",
    "status": "done",
    "created_at": "2024-01-01T11:00:00"
  }
]
```

---

### Create Task

- **Method:** `POST`
- **Path:** `/tasks`
- **Description:** Creates a new task for a given user.

**Request body (JSON):**

```json
{
  "user_id": 1,
  "title": "New Task",
  "description": "Optional description"
}
```

- `user_id` (required) – ID of the user in the `users` table.
- `title` (required) – Task title.
- `description` (optional) – Task description.

**Responses:**

- `201 Created` on success:

  ```json
  {
    "message": "Task created successfully"
  }
  ```

- `400 Bad Request` if required fields are missing:

  ```json
  {
    "error": "user_id and title are required"
  }
  ```

---

## Notes

- This backend is intentionally minimal and is used as a base API for DevOps and architecture demonstrations (containerization, OpenShift deployments, CI/CD pipelines, monitoring, etc.).
- Future projects that use this backend will live in separate repositories and reference this API as a demo service.


