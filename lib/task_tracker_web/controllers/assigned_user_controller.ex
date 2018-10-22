defmodule TaskTrackerWeb.AssignedUserController do
  use TaskTrackerWeb, :controller

  alias TaskTracker.Users
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
    id_of_manager = Users.get_user_by_email(Map.get(assigned_user_params, "manager_email")).id
    user_id_to_assign = String.to_integer(Map.get(assigned_user_params, "user_id"))
    # Checks for assigning users to managers
    curr_assigned_users = AssignedUsers.list_assigned_users_for_user_by_email(Map.get(assigned_user_params, "manager_email"))
    # Prevents managing the same user twice
    curr_assigned_ids = Enum.map(curr_assigned_users, fn user -> user.user.id end)
    if length(Enum.filter(curr_assigned_ids, fn user_id -> user_id == user_id_to_assign end)) == 0 do
      # Prevents managing yourself
      if id_of_manager !== user_id_to_assign do
        # Prevents managing a user that already has a manager
        all_assigned_users = AssignedUsers.list_assigned_users()
        all_assigned_ids = Enum.map(all_assigned_users, fn user -> user.user.id end)
        if length(Enum.filter(all_assigned_ids, fn user_id -> user_id == user_id_to_assign end)) == 0 do
          case AssignedUsers.create_assigned_user(assigned_user_params) do
            {:ok, assigned_user} ->
              conn
              |> put_flash(:info, "Assigned user created successfully.")
              |> redirect(to: Routes.user_path(conn, :show, id_of_manager))

            {:error, %Ecto.Changeset{} = changeset} ->
              render(conn, "new.html", changeset: changeset)
          end
        else
          conn
          |> put_flash(:error, "Cannot manage a user who already has a manager.")
          |> redirect(to: Routes.user_path(conn, :show, id_of_manager))
        end
      else
        conn
        |> put_flash(:error, "Cannot manage yourself.")
        |> redirect(to: Routes.user_path(conn, :show, id_of_manager))
      end
    else
      conn
      |> put_flash(:error, "Cannot manage a user you already manage.")
      |> redirect(to: Routes.user_path(conn, :show, id_of_manager))
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
    id_of_manager = Users.get_user_by_email(assigned_user.manager_email).id
    {:ok, _assigned_user} = AssignedUsers.delete_assigned_user(assigned_user)

    conn
    |> put_flash(:info, "Assigned user deleted successfully.")
    |> redirect(to: Routes.user_path(conn, :show, id_of_manager))
  end
end
