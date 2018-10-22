defmodule TaskTracker.AssignedUsersTest do
  use TaskTracker.DataCase

  alias TaskTracker.AssignedUsers

  describe "assigned_users" do
    alias TaskTracker.AssignedUsers.AssignedUser

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def assigned_user_fixture(attrs \\ %{}) do
      {:ok, assigned_user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> AssignedUsers.create_assigned_user()

      assigned_user
    end

    test "list_assigned_users/0 returns all assigned_users" do
      assigned_user = assigned_user_fixture()
      assert AssignedUsers.list_assigned_users() == [assigned_user]
    end

    test "get_assigned_user!/1 returns the assigned_user with given id" do
      assigned_user = assigned_user_fixture()
      assert AssignedUsers.get_assigned_user!(assigned_user.id) == assigned_user
    end

    test "create_assigned_user/1 with valid data creates a assigned_user" do
      assert {:ok, %AssignedUser{} = assigned_user} = AssignedUsers.create_assigned_user(@valid_attrs)
    end

    test "create_assigned_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = AssignedUsers.create_assigned_user(@invalid_attrs)
    end

    test "update_assigned_user/2 with valid data updates the assigned_user" do
      assigned_user = assigned_user_fixture()
      assert {:ok, %AssignedUser{} = assigned_user} = AssignedUsers.update_assigned_user(assigned_user, @update_attrs)

      
    end

    test "update_assigned_user/2 with invalid data returns error changeset" do
      assigned_user = assigned_user_fixture()
      assert {:error, %Ecto.Changeset{}} = AssignedUsers.update_assigned_user(assigned_user, @invalid_attrs)
      assert assigned_user == AssignedUsers.get_assigned_user!(assigned_user.id)
    end

    test "delete_assigned_user/1 deletes the assigned_user" do
      assigned_user = assigned_user_fixture()
      assert {:ok, %AssignedUser{}} = AssignedUsers.delete_assigned_user(assigned_user)
      assert_raise Ecto.NoResultsError, fn -> AssignedUsers.get_assigned_user!(assigned_user.id) end
    end

    test "change_assigned_user/1 returns a assigned_user changeset" do
      assigned_user = assigned_user_fixture()
      assert %Ecto.Changeset{} = AssignedUsers.change_assigned_user(assigned_user)
    end
  end
end
