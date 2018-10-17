defmodule TaskTracker.AssignedTasks do
  @moduledoc """
  The AssignedTasks context.
  """

  import Ecto.Query, warn: false
  alias TaskTracker.Repo

  alias TaskTracker.AssignedTasks.AssignedTask

  @doc """
  Returns the list of assigned_tasks.

  ## Examples

      iex> list_assigned_tasks()
      [%AssignedTask{}, ...]

  """
  def list_assigned_tasks do
    Repo.all(AssignedTask)
  end

  @doc """
  Gets a single assigned_task.

  Raises `Ecto.NoResultsError` if the Assigned task does not exist.

  ## Examples

      iex> get_assigned_task!(123)
      %AssignedTask{}

      iex> get_assigned_task!(456)
      ** (Ecto.NoResultsError)

  """
  def get_assigned_task!(id), do: Repo.get!(AssignedTask, id)

  @doc """
  Creates a assigned_task.

  ## Examples

      iex> create_assigned_task(%{field: value})
      {:ok, %AssignedTask{}}

      iex> create_assigned_task(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_assigned_task(attrs \\ %{}) do
    %AssignedTask{}
    |> AssignedTask.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a assigned_task.

  ## Examples

      iex> update_assigned_task(assigned_task, %{field: new_value})
      {:ok, %AssignedTask{}}

      iex> update_assigned_task(assigned_task, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_assigned_task(%AssignedTask{} = assigned_task, attrs) do
    assigned_task
    |> AssignedTask.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a AssignedTask.

  ## Examples

      iex> delete_assigned_task(assigned_task)
      {:ok, %AssignedTask{}}

      iex> delete_assigned_task(assigned_task)
      {:error, %Ecto.Changeset{}}

  """
  def delete_assigned_task(%AssignedTask{} = assigned_task) do
    Repo.delete(assigned_task)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking assigned_task changes.

  ## Examples

      iex> change_assigned_task(assigned_task)
      %Ecto.Changeset{source: %AssignedTask{}}

  """
  def change_assigned_task(%AssignedTask{} = assigned_task) do
    AssignedTask.changeset(assigned_task, %{})
  end
end
