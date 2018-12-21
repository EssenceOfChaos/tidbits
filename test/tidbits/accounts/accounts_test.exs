defmodule Tidbits.AccountsTest do
  use Tidbits.DataCase

  alias Tidbits.Accounts

  describe "users" do
    alias Tidbits.Accounts.User

    @valid_attrs %{avatar: "https://i.imgur.com/egBSAAb.png", display_name: "cooldude19", email: "cooldude@aol.com", is_admin: false, password_hash: "abc123"}
    @update_attrs %{avatar: "https://i.imgur.com/XHz8rWj.png", display_name: "updated-dude19", email: "cooldude2@aol.com", is_admin: false, password_hash: "abc123123abc"}
    @invalid_attrs %{avatar: nil, display_name: nil, email: nil, is_admin: nil, password_hash: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.avatar == "some avatar"
      assert user.display_name == "some display_name"
      assert user.email == "some email"
      assert user.is_admin == true
      assert user.password_hash == "some password_hash"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Accounts.update_user(user, @update_attrs)
      assert user.avatar == "some updated avatar"
      assert user.display_name == "some updated display_name"
      assert user.email == "some updated email"
      assert user.is_admin == false
      assert user.password_hash == "some updated password_hash"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end
end
