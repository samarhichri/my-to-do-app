const taskForm = document.getElementById('task-form');
const taskList = document.getElementById('task-list');

const API_URL = "http://localhost:5000";  

// Fetch tasks from backend
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

// Add task to backend
taskForm.addEventListener('submit', async function(e) {
  e.preventDefault();

  const title = document.getElementById('title').value.trim();
  const description = document.getElementById('description').value.trim();

  if (!title) return;

  await fetch(`${API_URL}/tasks`, {
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

  taskForm.reset();
  fetchTasks();
});

// Load tasks when page loads
fetchTasks();