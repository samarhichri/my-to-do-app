---
# To-Do App Frontend

This is the frontend for the To-Do application. It is a simple, static web UI that interacts with the Flask backend via a small JavaScript file.

The frontend is intentionally lightweight (HTML, CSS, JavaScript) so it can be easily served from any static web server or container and reused for DevOps and platform demonstrations.

---

## Tech Stack

- HTML5
- CSS3
- JavaScript 
- Browser Fetch API

---

## Project Structure

```text
frontend/
├── index.html   # Main HTML page
├── style.css    # Styling for the app
└── app.js       # Frontend logic and API calls
```

---

## Application Overview

### `index.html`

Defines the UI structure:

- Header: Application title.
- Main content:
  - **Add a Task** section with:
    - Text input for task title (required).
    - Textarea for optional description.
    - Submit button.
  - **Task List** section:
    - An unordered list (`<ul id="task-list">`) that will be populated dynamically from the backend.
- Footer: “Production Journey Series”.

---

### `style.css`

Provides basic styling:

- Global font and background.
- Black header and footer with white text.
- Centered main content with a max width of 800px.
- Form and task list styling with a red accent color.

This keeps the UI clean and readable while remaining minimal.

---

### `app.js`

Implements the frontend logic and communication with the backend API.

Key parts:

```javascript
const taskForm = document.getElementById('task-form');
const taskList = document.getElementById('task-list');
const API_URL = "http://localhost:5000";
```

- `API_URL` points to the backend Flask service, which is expected to run on `http://localhost:5000` in local development.

#### Fetching tasks

```javascript
async function fetchTasks() {
  const response = await fetch(`${API_URL}/tasks`);
  const tasks = await response.json();

  taskList.innerHTML = '';

  tasks.forEach(task => {
    const li = document.createElement('li');
    li.textContent = `${task.title} - ${task.description} (${task.status})`;
    taskList.appendChild(li);
  });
}
```

- Makes a `GET /tasks` request to the backend.
- Clears the current list and appends each task as a `<li>` element.
- Displays task title, description, and status.

#### Creating a task

```javascript
taskForm.addEventListener('submit', async function(e) {
  e.preventDefault();

  const title = document.getElementById('title').value.trim();
  const description = document.getElementById('description').value.trim();

  if (!title) return;

  await fetch(`${API_URL}/tasks`, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({
      user_id: 1,
      title: title,
      description: description
    })
  });

  taskForm.reset();
  fetchTasks();
});
```

- Prevents default form submission.
- Reads and trims the `title` and `description` fields.
- If `title` is empty, it aborts.
- Sends a `POST /tasks` request to the backend with:
  - `user_id` hardcoded as `1` (for demo purposes, matching seeded data).
  - `title` and `description` from the form.
- After a successful request, it resets the form and refreshes the task list.

#### Initial load

```javascript
// Load tasks when page loads
fetchTasks();
```

- Automatically loads existing tasks when the page is opened.

---

## Prerequisites

- A modern web browser.
- The backend service running and reachable at `http://localhost:5000` (or change `API_URL` accordingly if you host it elsewhere).

---

## How to Run the Frontend Locally

Simplest Option : **Open directly in a browser** 

1. Ensure the backend is running at `http://localhost:5000`.
2. Open `frontend/index.html` in your browser (double-click, or use “Open File” in the browser).

---

## Notes

- This frontend is intentionally minimal to focus on DevOps and architecture demonstrations (building, deploying, and exposing a simple web UI that talks to an API).
- Future DevOps/OpenShift/CI-CD projects will use this frontend as a demo client but will live in separate repositories.

