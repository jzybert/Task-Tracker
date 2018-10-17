defmodule TaskTracker.AssignedTasksTest do
  use TaskTracker.DataCase

  alias TaskTracker.AssignedTasks

  describe "assigned_tasks" do
    alias TaskTracker.AssignedTasks.AssignedTask

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def assigned_task_fixture(attrs \\ %{}) do
      {:ok, assigned_task} =
        attrs
        |> Enum.into(@valid_attrs)
        |> AssignedTasks.create_assigned_task()

      assigned_task
    end

    test "list_assigned_tasks/0 returns all assigned_tasks" do
      assigned_task = assigned_task_fixture()
      assert AssignedTasks.list_assigned_tasks() == [assigned_task]
    end

    test "get_assigned_task!/1 returns the assigned_task with given id" do
      assigned_task = assigned_task_fixture()
      assert AssignedTasks.get_assigned_task!(assigned_task.id) == assigned_task
    end

    test "create_assigned_task/1 with valid data creates a assigned_task" do
      assert {:ok, %AssignedTask{} = assigned_task} = AssignedTasks.create_assigned_task(@valid_attrs)
    end

    test "create_assigned_task/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = AssignedTasks.create_assigned_task(@invalid_attrs)
    end

    test "update_assigned_task/2 with valid data updates the assigned_task" do
      assigned_task = assigned_task_fixture()
      assert {:ok, %AssignedTask{} = assigned_task} = AssignedTasks.update_assigned_task(assigned_task, @update_attrs)

      
    end

    test "update_assigned_task/2 with invalid data returns error changeset" do
      assigned_task = assigned_task_fixture()
      assert {:error, %Ecto.Changeset{}} = AssignedTasks.update_assigned_task(assigned_task, @invalid_attrs)
      assert assigned_task == AssignedTasks.get_assigned_task!(assigned_task.id)
    end

    test "delete_assigned_task/1 deletes the assigned_task" do
      assigned_task = assigned_task_fixture()
      assert {:ok, %AssignedTask{}} = AssignedTasks.delete_assigned_task(assigned_task)
      assert_raise Ecto.NoResultsError, fn -> AssignedTasks.get_assigned_task!(assigned_task.id) end
    end

    test "change_assigned_task/1 returns a assigned_task changeset" do
      assigned_task = assigned_task_fixture()
      assert %Ecto.Changeset{} = AssignedTasks.change_assigned_task(assigned_task)
    end
  end
end
