defmodule TaskTracker.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :assigned_user, references(:tasks)
      add :title, :string
      add :desc, :text
      add :time_worked, :time
      add :is_complete, :boolean, default: false, null: false

      timestamps()
    end

  end
end
