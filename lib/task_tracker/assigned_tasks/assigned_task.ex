defmodule TaskTracker.AssignedTasks.AssignedTask do
  use Ecto.Schema
  import Ecto.Changeset


  schema "assigned_tasks" do
    belongs_to :user, TaskTracker.Users.User
    belongs_to :task, TaskTracker.Tasks.Task

    timestamps()
  end

  @doc false
  def changeset(assigned_task, attrs) do
    assigned_task
    |> cast(attrs, [:user_id, :task_id])
    |> validate_required([:user_id, :task_id])
  end
end
