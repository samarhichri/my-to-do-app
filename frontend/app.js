const taskForm = document.getElementById("task-form");
const taskList = document.getElementById("task-list");
const formMessage = document.getElementById("form-message");
const listMessage = document.getElementById("list-message");
const submitButton = taskForm.querySelector("button");


const API_URL = "http://localhost:5000";

function showMessage(element, message, type = "") {
  element.textContent = message;
  element.className = `message ${type}`.trim();
}


function clearMessage(element) {
  element.textContent = "";
  element.className = "message";
}


async function fetchTasks() {
  clearMessage(listMessage);

  try {
    const response = await fetch(`${API_URL}/tasks`);

    if (!response.ok) {
      throw new Error("Unable to load tasks.");
    }

    const tasks = await response.json();

    taskList.innerHTML = "";

    if (tasks.length === 0) {
      showMessage(listMessage, "No tasks yet.");
      return;
    }

    tasks.forEach(task => {
      const li = document.createElement("li");

      const title = document.createElement("h3");
      title.textContent = task.title;

      const description = document.createElement("p");
      description.textContent = task.description || "No description";

      const status = document.createElement("span");
      status.textContent = task.status;
      status.className = `status status-${task.status}`;

      li.appendChild(title);
      li.appendChild(description);
      li.appendChild(status);

      taskList.appendChild(li);
    });

  } catch (error) {
    showMessage(
      listMessage,
      "Unable to connect to the server. Please try again.",
      "error"
    );

    console.error(error);
  }
}


// Add task

taskForm.addEventListener("submit", async function (event) {
  event.preventDefault();

  clearMessage(formMessage);

  const title = document.getElementById("title").value.trim();
  const description = document.getElementById("description").value.trim();

  if (!title) {
    showMessage(formMessage, "Please enter a task title.", "error");
    return;
  }

  submitButton.disabled = true;
  submitButton.textContent = "Adding...";

  try {
    const response = await fetch(`${API_URL}/tasks`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify({
        user_id: 1,
        title: title,
        description: description
      })
    });

    const data = await response.json();

    if (!response.ok) {
      throw new Error(data.error || "Unable to create task.");
    }

    taskForm.reset();

    showMessage(
      formMessage,
      "Task created successfully.",
      "success"
    );

    await fetchTasks();

  } catch (error) {
    showMessage(
      formMessage,
      error.message || "Unable to create task.",
      "error"
    );

    console.error(error);

  } finally {
    submitButton.disabled = false;
    submitButton.textContent = "Add Task";
  }
});


fetchTasks();
