defmodule TaskTrackerWeb.UserController do
  use TaskTrackerWeb, :controller

  alias TaskTracker.Users
  alias TaskTracker.Users.User
  alias TaskTracker.AssignedUsers
  alias TaskTracker.AssignedTasks

  def index(conn, _params) do
    users = Users.list_users()
    render(conn, "index.html", users: users)
  end

  def new(conn, _params) do
    changeset = Users.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Users.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> put_session(:user_id, user.id)
        |> redirect(to: Routes.task_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    user_id = get_session(conn, :user_id)
    tasks_for_user = AssignedTasks.list_assigned_tasks_for_user(id)
    assigned_users = AssignedUsers.list_assigned_users_for_user_by_email(user.email)
    user_cset = AssignedUsers.change_assigned_user(%AssignedUsers.AssignedUser{
      user_id: id, manager_email: Users.get_user(user_id).email
    })
    reporter_tasks = Enum.map(assigned_users,
      fn user -> %{:email => user.user.email, :tasks => AssignedTasks.list_assigned_tasks_for_user(user.user_id)} end)
    manager_list = AssignedUsers.list_assigned_users_for_user(id)
    if length(manager_list) == 0 do
      render(conn, "show.html", user: user, tasks: tasks_for_user,
        user_cset: user_cset, users: assigned_users, manager: "N/A", reporter_tasks: reporter_tasks)
    else
      render(conn, "show.html", user: user, tasks: tasks_for_user,
        user_cset: user_cset, users: assigned_users, manager: (hd manager_list).manager_email,
        reporter_tasks: reporter_tasks)
    end
  end

  def edit(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    changeset = Users.change_user(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Users.get_user!(id)

    case Users.update_user(user, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: Routes.user_path(conn, :show, user))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    {:ok, _user} = Users.delete_user(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: Routes.user_path(conn, :index))
  end
end
