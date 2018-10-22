defmodule TaskTrackerWeb.AssignedUserController do
  use TaskTrackerWeb, :controller

  alias TaskTracker.AssignedUsers
  alias TaskTracker.AssignedUsers.AssignedUser

  def index(conn, _params) do
    assigned_users = AssignedUsers.list_assigned_users()
    render(conn, "index.html", assigned_users: assigned_users)
  end

  def new(conn, _params) do
    changeset = AssignedUsers.change_assigned_user(%AssignedUser{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"assigned_user" => assigned_user_params}) do
    case AssignedUsers.create_assigned_user(assigned_user_params) do
      {:ok, assigned_user} ->
        conn
        |> put_flash(:info, "Assigned user created successfully.")
        |> redirect(to: Routes.assigned_user_path(conn, :show, assigned_user))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    assigned_user = AssignedUsers.get_assigned_user!(id)
    render(conn, "show.html", assigned_user: assigned_user)
  end

  def edit(conn, %{"id" => id}) do
    assigned_user = AssignedUsers.get_assigned_user!(id)
    changeset = AssignedUsers.change_assigned_user(assigned_user)
    render(conn, "edit.html", assigned_user: assigned_user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "assigned_user" => assigned_user_params}) do
    assigned_user = AssignedUsers.get_assigned_user!(id)

    case AssignedUsers.update_assigned_user(assigned_user, assigned_user_params) do
      {:ok, assigned_user} ->
        conn
        |> put_flash(:info, "Assigned user updated successfully.")
        |> redirect(to: Routes.assigned_user_path(conn, :show, assigned_user))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", assigned_user: assigned_user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    assigned_user = AssignedUsers.get_assigned_user!(id)
    {:ok, _assigned_user} = AssignedUsers.delete_assigned_user(assigned_user)

    conn
    |> put_flash(:info, "Assigned user deleted successfully.")
    |> redirect(to: Routes.assigned_user_path(conn, :index))
  end
end
