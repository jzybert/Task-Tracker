defmodule TaskTracker.Repo.Migrations.CreateAssignedUsers do
  use Ecto.Migration

  def change do
    create table(:assigned_users) do
      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:assigned_users, [:user_id])
  end
end
