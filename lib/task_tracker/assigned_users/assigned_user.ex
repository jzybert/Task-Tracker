defmodule TaskTracker.AssignedUsers.AssignedUser do
  use Ecto.Schema
  import Ecto.Changeset


  schema "assigned_users" do
    field :manager_email, :string, null: false
    belongs_to :user, TaskTracker.Users.User

    timestamps()
  end

  @doc false
  def changeset(assigned_user, attrs) do
    assigned_user
    |> cast(attrs, [:manager_email, :user_id])
    |> validate_required([:manager_email, :user_id])
  end
end
