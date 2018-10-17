defmodule TaskTrackerWeb.AssignedTaskControllerTest do
  use TaskTrackerWeb.ConnCase

  alias TaskTracker.AssignedTasks

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:assigned_task) do
    {:ok, assigned_task} = AssignedTasks.create_assigned_task(@create_attrs)
    assigned_task
  end

  describe "index" do
    test "lists all assigned_tasks", %{conn: conn} do
      conn = get(conn, Routes.assigned_task_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Assigned tasks"
    end
  end

  describe "new assigned_task" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.assigned_task_path(conn, :new))
      assert html_response(conn, 200) =~ "New Assigned task"
    end
  end

  describe "create assigned_task" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.assigned_task_path(conn, :create), assigned_task: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.assigned_task_path(conn, :show, id)

      conn = get(conn, Routes.assigned_task_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Assigned task"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.assigned_task_path(conn, :create), assigned_task: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Assigned task"
    end
  end

  describe "edit assigned_task" do
    setup [:create_assigned_task]

    test "renders form for editing chosen assigned_task", %{conn: conn, assigned_task: assigned_task} do
      conn = get(conn, Routes.assigned_task_path(conn, :edit, assigned_task))
      assert html_response(conn, 200) =~ "Edit Assigned task"
    end
  end

  describe "update assigned_task" do
    setup [:create_assigned_task]

    test "redirects when data is valid", %{conn: conn, assigned_task: assigned_task} do
      conn = put(conn, Routes.assigned_task_path(conn, :update, assigned_task), assigned_task: @update_attrs)
      assert redirected_to(conn) == Routes.assigned_task_path(conn, :show, assigned_task)

      conn = get(conn, Routes.assigned_task_path(conn, :show, assigned_task))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, assigned_task: assigned_task} do
      conn = put(conn, Routes.assigned_task_path(conn, :update, assigned_task), assigned_task: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Assigned task"
    end
  end

  describe "delete assigned_task" do
    setup [:create_assigned_task]

    test "deletes chosen assigned_task", %{conn: conn, assigned_task: assigned_task} do
      conn = delete(conn, Routes.assigned_task_path(conn, :delete, assigned_task))
      assert redirected_to(conn) == Routes.assigned_task_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.assigned_task_path(conn, :show, assigned_task))
      end
    end
  end

  defp create_assigned_task(_) do
    assigned_task = fixture(:assigned_task)
    {:ok, assigned_task: assigned_task}
  end
end
