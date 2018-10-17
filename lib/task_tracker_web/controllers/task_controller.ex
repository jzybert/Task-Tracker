defmodule TaskTrackerWeb.TaskController do
  use TaskTrackerWeb, :controller

  alias TaskTracker.Tasks
  alias TaskTracker.Tasks.Task
  alias TaskTracker.AssignedTasks
  alias TaskTracker.Users

  def index(conn, _params) do
    tasks = Tasks.list_tasks()
    render(conn, "index.html", tasks: tasks)
  end

  def new(conn, _params) do
    changeset = Tasks.change_task(%Task{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"task" => task_params}) do
    case Tasks.create_task(task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task created successfully.")
        |> redirect(to: Routes.task_path(conn, :show, task))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    user_id = get_session(conn, :user_id)
    users_list = Enum.map Users.list_users(), fn(user) -> user.email end
    task_cset = AssignedTasks.change_assigned_task(%AssignedTasks.AssignedTask{
      user_id: user_id, task_id: task.id
    })
    render(conn, "show.html", task: task, task_cset: task_cset, users: users_list)
  end

  def edit(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    user_id = get_session(conn, :user_id)
    assigned_task_ids = Enum.map AssignedTasks.list_assigned_tasks_for_user(user_id), fn(t) -> t.task.id end
    is_task_assigned_to_user = task.id in assigned_task_ids
    changeset = Tasks.change_task(task)
    render(conn, "edit.html", task: task, changeset: changeset, is_task_assigned_to_user: is_task_assigned_to_user)
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    task = Tasks.get_task!(id)

    case Tasks.update_task(task, task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task updated successfully.")
        |> redirect(to: Routes.task_path(conn, :show, task))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", task: task, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    {:ok, _task} = Tasks.delete_task(task)

    conn
    |> put_flash(:info, "Task deleted successfully.")
    |> redirect(to: Routes.task_path(conn, :index))
  end
end
