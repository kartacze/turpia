defmodule Turpia.HolderTest do
  use Turpia.DataCase

  alias Turpia.Holder

  describe "wallets" do
    alias Turpia.Holder.Wallets

    import Turpia.HolderFixtures

    @invalid_attrs %{id: nil, name: nil, type: nil, currency: nil, quantity: nil, tens: nil}

    test "list_wallets/0 returns all wallets" do
      wallets = wallets_fixture()
      assert Holder.list_wallets() == [wallets]
    end

    test "get_wallets!/1 returns the wallets with given id" do
      wallets = wallets_fixture()
      assert Holder.get_wallets!(wallets.id) == wallets
    end

    test "create_wallets/1 with valid data creates a wallets" do
      valid_attrs = %{
        type: "type",
        name: "wallet name",
        currency: "PLN",
        quantity: 42,
        tens: 10
      }

      assert {:ok, %Wallets{} = wallets} = Holder.create_wallets(valid_attrs)
      assert wallets.name == "wallet name"
      assert wallets.type == "type"
      assert wallets.currency == "PLN"
      assert wallets.quantity == 42
      assert wallets.tens == 10
    end

    test "create_wallets/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Holder.create_wallets(@invalid_attrs)
    end

    test "update_wallets/2 with valid data updates the wallets" do
      wallets = wallets_fixture()

      update_attrs = %{
        name: "some updated name",
        type: "some updated type",
        currency: "some updated currency",
        quantity: 43,
        tens: 43
      }

      assert {:ok, %Wallets{} = wallets} = Holder.update_wallets(wallets, update_attrs)
      assert wallets.name == "some updated name"
      assert wallets.type == "some updated type"
      assert wallets.currency == "some updated currency"
      assert wallets.quantity == 43
      assert wallets.tens == 43
    end

    test "update_wallets/2 with invalid data returns error changeset" do
      wallets = wallets_fixture()
      assert {:error, %Ecto.Changeset{}} = Holder.update_wallets(wallets, @invalid_attrs)
      assert wallets == Holder.get_wallets!(wallets.id)
    end

    test "delete_wallets/1 deletes the wallets" do
      wallets = wallets_fixture()
      assert {:ok, %Wallets{}} = Holder.delete_wallets(wallets)
      assert_raise Ecto.NoResultsError, fn -> Holder.get_wallets!(wallets.id) end
    end

    test "change_wallets/1 returns a wallets changeset" do
      wallets = wallets_fixture()
      assert %Ecto.Changeset{} = Holder.change_wallets(wallets)
    end
  end
end
