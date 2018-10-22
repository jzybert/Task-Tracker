defmodule TaskTracker.AssignedUsers do
  @moduledoc """
  The AssignedUsers context.
  """

  import Ecto.Query, warn: false
  alias TaskTracker.Repo

  alias TaskTracker.AssignedUsers.AssignedUser

  @doc """
  Returns the list of assigned_users.

  ## Examples

      iex> list_assigned_users()
      [%AssignedUser{}, ...]

  """
  def list_assigned_users() do
    Repo.all from u in AssignedUser,
      preload: [:user]
  end

  @doc """
  Returns the list of assigned users for a manager email.

  """
  def list_assigned_users_for_user_by_email(email) do
    Repo.all from u in AssignedUser,
      where: u.manager_email == ^email,
      preload: [:user]
  end

  @doc """
  Returns the list of assigned users for a given id.
  """
  def list_assigned_users_for_user(id) do
    Repo.all from u in AssignedUser,
      where: u.user_id == ^id,
      preload: [:user]
  end

  @doc """
  Gets a single assigned_user.

  Raises `Ecto.NoResultsError` if the Assigned user does not exist.

  ## Examples

      iex> get_assigned_user!(123)
      %AssignedUser{}

      iex> get_assigned_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_assigned_user!(id), do: Repo.get!(AssignedUser, id)

  @doc """
  Creates a assigned_user.

  ## Examples

      iex> create_assigned_user(%{field: value})
      {:ok, %AssignedUser{}}

      iex> create_assigned_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_assigned_user(attrs \\ %{}) do
    %AssignedUser{}
    |> AssignedUser.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a assigned_user.

  ## Examples

      iex> update_assigned_user(assigned_user, %{field: new_value})
      {:ok, %AssignedUser{}}

      iex> update_assigned_user(assigned_user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_assigned_user(%AssignedUser{} = assigned_user, attrs) do
    assigned_user
    |> AssignedUser.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a AssignedUser.

  ## Examples

      iex> delete_assigned_user(assigned_user)
      {:ok, %AssignedUser{}}

      iex> delete_assigned_user(assigned_user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_assigned_user(%AssignedUser{} = assigned_user) do
    Repo.delete(assigned_user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking assigned_user changes.

  ## Examples

      iex> change_assigned_user(assigned_user)
      %Ecto.Changeset{source: %AssignedUser{}}

  """
  def change_assigned_user(%AssignedUser{} = assigned_user) do
    AssignedUser.changeset(assigned_user, %{})
  end
end
