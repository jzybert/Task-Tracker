defmodule TaskTracker.Repo.Migrations.CreateAssignedTasks do
  use Ecto.Migration

  def change do
    create table(:assigned_tasks) do
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :task_id, references(:tasks, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:assigned_tasks, [:user_id])
    create index(:assigned_tasks, [:task_id])
  end
end
