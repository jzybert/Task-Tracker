defmodule TaskTracker.Users.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
    field :email, :string
    field :admin, :boolean, default: false, null: false

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :admin])
    |> validate_required([:email, :admin])
  end
end
