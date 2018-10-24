# Task-Tracker

## How To Run Task Tracker
- Install dependencies with mix deps.get
- Install Node.js dependencies with cd assets && npm install
- Start Phoenix endpoint with mix phx.server

Now you can visit [localhost:4000](localhost:4000) from your browser.

Note: Login as **admin@jonathanzybert.com** for admin access.

## Design Choices
### Three databases:
- Users
  - Keeps track of registered users
  - Fields: email, admin status
  - HTML
- Tasks
  - Keeps track of created tasks
  - Fields: title, description, time worked, complete status
  - HTML
- Assigned Tasks
  - Keeps track of tasks assigned to users
  - Fields: user_id, task_id
  - HTML
- Assigned Users
  - Allows for users to manage other users
  - HTML
- Time Blocks
  - Allows for tracking time periods for working on tasks
  - JSON
  
### Managers:
Anyone can select to manage a user. Only a user's manager can assign them tasks.
If a user has no manager, they can assign themselves tasks.

### Time Worked:
There are two ways to enter time worked. Both involve navigating to a task's edit page.
On the edit page, a user can type time worked in (start, end) blocks separated by a semi-colon.
Clicking "Add Time" will create time blocks and automatically click save so that the time worked updates.

The other option is to click "Start Working". This will track that amount of time until you
click "Stop Working". Of note, you cannot leave the page while using this feature. You will lose
the initial start time.

## Time Blocks on Task Edit Page
A time block can be deleted by clicking the "Delete" button. Of note, the screen will not update until you
navigate away and back to the page.

### Style:
Assigned tasks to the current user will always display on the right-hand side
of the screen. This allows easy access to see what you're assigned
to and edit them.

User pages can be accessed through the User tab in the navbar and clicking
on individual users will display tasks assigned to only them.