defmodule TaskTrackerWeb.AssignedTaskController do
  use TaskTrackerWeb, :controller

  alias TaskTracker.Repo
  alias TaskTracker.AssignedTasks
  alias TaskTracker.AssignedTasks.AssignedTask
  alias TaskTracker.Users

  def index(conn, _params) do
    assigned_tasks = AssignedTasks.list_assigned_tasks()
    render(conn, "index.html", assigned_tasks: assigned_tasks)
  end

  def new(conn, _params) do
    changeset = AssignedTasks.change_assigned_task(%AssignedTask{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"assigned_task" => assigned_task_params}) do
    user_id = Users.get_user_by_email(Map.get(assigned_task_params, "user_id", "")).id
    assigned_task_params_with_id = assigned_task_params
    |> Map.put("user_id", user_id)
    case AssignedTasks.create_assigned_task(assigned_task_params_with_id) do
      {:ok, assigned_task} ->
        conn
        |> put_flash(:info, "Assigned task created successfully.")
        |> redirect(to: Routes.task_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    assigned_task = AssignedTasks.get_assigned_task!(id)
    render(conn, "show.html", assigned_task: assigned_task)
  end

  def edit(conn, %{"id" => id}) do
    assigned_task = AssignedTasks.get_assigned_task!(id)
    changeset = AssignedTasks.change_assigned_task(assigned_task)
    render(conn, "edit.html", assigned_task: assigned_task, changeset: changeset)
  end

  def update(conn, %{"id" => id, "assigned_task" => assigned_task_params}) do
    assigned_task = AssignedTasks.get_assigned_task!(id)

    case AssignedTasks.update_assigned_task(assigned_task, assigned_task_params) do
      {:ok, assigned_task} ->
        conn
        |> put_flash(:info, "Assigned task updated successfully.")
        |> redirect(to: Routes.assigned_task_path(conn, :show, assigned_task))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", assigned_task: assigned_task, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    assigned_task = AssignedTasks.get_assigned_task!(id)
    {:ok, _assigned_task} = AssignedTasks.delete_assigned_task(assigned_task)

    conn
    |> put_flash(:info, "Assigned task deleted successfully.")
    |> redirect(to: Routes.task_path(conn, :index))
  end
end
