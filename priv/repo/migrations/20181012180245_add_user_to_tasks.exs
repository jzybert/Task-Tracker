defmodule TaskTracker.Repo.Migrations.AddUserToTasks do
  use Ecto.Migration

  def change do
    alter table(:tasks) do
      add :assigned_user, :string
    end
  end
end
