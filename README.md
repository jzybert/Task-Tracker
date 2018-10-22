# Task-Tracker

## How To Run Task Tracker
- Install dependencies with mix deps.get
- Install Node.js dependencies with cd assets && npm install
- Start Phoenix endpoint with mix phx.server

Now you can visit [localhost:4000](localhost:4000) from your browser.

Note: Login as **admin@jonathanzybert.com** for admin access.

## Design Choices
Three databases:
- Users
  - Keeps track of registered users
  - Fields: email, admin status
- Tasks
  - Keeps track of created tasks
  - Fields: title, description, time worked, complete status
- Assigned Tasks
  - Keeps track of tasks assigned to users
  - Fields: user_id, task_id

Style:

Assigned tasks to the current user will always display on the right-hand side
of the screen. This allows easy access to see what you're assigned
to and edit them.

User pages can be accessed through the User tab in the navbar and clicking
on individual users will display tasks assigned to only them.