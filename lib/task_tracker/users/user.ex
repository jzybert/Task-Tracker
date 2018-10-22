defmodule TaskTracker.Users.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
    field :email, :string
    field :admin, :boolean, default: false, null: false

    has_many :assigned_tasks, TaskTracker.AssignedTasks.AssignedTask
    has_many :assigned_users, TaskTracker.AssignedUsers.AssignedUser

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :admin])
    |> validate_required([:email, :admin])
  end
end
