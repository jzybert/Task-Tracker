defmodule TaskTracker.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset


  schema "tasks" do
    field :desc, :string
    field :is_complete, :boolean, default: false
    field :time_worked, :time
    field :title, :string

    has_many :assigned_tasks, TaskTracker.AssignedTasks.AssignedTask

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :desc, :time_worked, :is_complete])
    |> validate_required([:title, :desc, :time_worked, :is_complete])
  end
end
