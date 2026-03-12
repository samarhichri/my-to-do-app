from flask import Blueprint, jsonify, request
from models import get_all_tasks, create_task

api = Blueprint("api", __name__)


@api.route("/health", methods=["GET"])
def health():
    return jsonify({"status": "ok"}), 200


@api.route("/tasks", methods=["GET"])
def list_tasks():
    tasks = get_all_tasks()
    return jsonify(tasks), 200


@api.route("/tasks", methods=["POST"])
def add_task():
    data = request.get_json()

    user_id = data.get("user_id")
    title = data.get("title")
    description = data.get("description", "")

    if not user_id or not title:
        return jsonify({"error": "user_id and title are required"}), 400

    create_task(user_id, title, description)
    return jsonify({"message": "Task created successfully"}), 201