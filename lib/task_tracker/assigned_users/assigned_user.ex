defmodule TaskTracker.AssignedUsers.AssignedUser do
  use Ecto.Schema
  import Ecto.Changeset


  schema "assigned_users" do
    belongs_to :user, TaskTracker.Users.User

    timestamps()
  end

  @doc false
  def changeset(assigned_user, attrs) do
    assigned_user
    |> cast(attrs, [:user_id])
    |> validate_required([:user_id])
  end
end
