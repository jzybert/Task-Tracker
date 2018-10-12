defmodule TaskTracker.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset


  schema "tasks" do
    field :assigned_user, :string
    field :desc, :string
    field :is_complete, :boolean, default: false
    field :time_worked, :time
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:assigned_user, :title, :desc, :time_worked, :is_complete])
    |> validate_required([:assigned_user, :title, :desc, :time_worked, :is_complete])
  end
end
