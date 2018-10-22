defmodule TaskTrackerWeb.AssignedUserControllerTest do
  use TaskTrackerWeb.ConnCase

  alias TaskTracker.AssignedUsers

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:assigned_user) do
    {:ok, assigned_user} = AssignedUsers.create_assigned_user(@create_attrs)
    assigned_user
  end

  describe "index" do
    test "lists all assigned_users", %{conn: conn} do
      conn = get(conn, Routes.assigned_user_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Assigned users"
    end
  end

  describe "new assigned_user" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.assigned_user_path(conn, :new))
      assert html_response(conn, 200) =~ "New Assigned user"
    end
  end

  describe "create assigned_user" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.assigned_user_path(conn, :create), assigned_user: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.assigned_user_path(conn, :show, id)

      conn = get(conn, Routes.assigned_user_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Assigned user"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.assigned_user_path(conn, :create), assigned_user: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Assigned user"
    end
  end

  describe "edit assigned_user" do
    setup [:create_assigned_user]

    test "renders form for editing chosen assigned_user", %{conn: conn, assigned_user: assigned_user} do
      conn = get(conn, Routes.assigned_user_path(conn, :edit, assigned_user))
      assert html_response(conn, 200) =~ "Edit Assigned user"
    end
  end

  describe "update assigned_user" do
    setup [:create_assigned_user]

    test "redirects when data is valid", %{conn: conn, assigned_user: assigned_user} do
      conn = put(conn, Routes.assigned_user_path(conn, :update, assigned_user), assigned_user: @update_attrs)
      assert redirected_to(conn) == Routes.assigned_user_path(conn, :show, assigned_user)

      conn = get(conn, Routes.assigned_user_path(conn, :show, assigned_user))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, assigned_user: assigned_user} do
      conn = put(conn, Routes.assigned_user_path(conn, :update, assigned_user), assigned_user: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Assigned user"
    end
  end

  describe "delete assigned_user" do
    setup [:create_assigned_user]

    test "deletes chosen assigned_user", %{conn: conn, assigned_user: assigned_user} do
      conn = delete(conn, Routes.assigned_user_path(conn, :delete, assigned_user))
      assert redirected_to(conn) == Routes.assigned_user_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.assigned_user_path(conn, :show, assigned_user))
      end
    end
  end

  defp create_assigned_user(_) do
    assigned_user = fixture(:assigned_user)
    {:ok, assigned_user: assigned_user}
  end
end
