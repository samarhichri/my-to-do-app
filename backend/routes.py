from flask import Blueprint, jsonify, request
from models import get_all_tasks, create_task

api = Blueprint("api", __name__)


@api.route("/health", methods=["GET"])
def health():
    return jsonify({"status": "ok"}), 200


@api.route("/tasks", methods=["GET"])
def list_tasks():
    try:
        tasks = get_all_tasks()
        return jsonify(tasks), 200

    except Exception:
        return jsonify({"error": "Unable to retrieve tasks"}), 500


@api.route("/tasks", methods=["POST"])
def add_task():
    data = request.get_json(silent=True)

    user_id = data.get("user_id")
    title = data.get("title")
    description = data.get("description", "")

    if user_id is None or title is None:
        return jsonify({"error": "user_id and title are required"}), 400

    if not isinstance(user_id, int):
        return jsonify({"error": "user_id must be an integer"}), 400

    if not isinstance(title, str) or not title.strip():
        return jsonify({"error": "title must be a non-empty string"}), 400

    if not isinstance(description, str):
        return jsonify({"error": "description must be a string"}), 400

    title = title.strip()
    description = description.strip()

    try:
        task_id = create_task(user_id, title, description)

        return jsonify(
            {
                "message": "Task created successfully",
                "task_id": task_id,
            }
        ), 201

    except Exception:
        return jsonify({"error": "Unable to create task"}), 500
