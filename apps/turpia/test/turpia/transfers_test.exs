defmodule Turpia.TransfersTest do
  use Turpia.DataCase

  alias Turpia.Transfers

  describe "transfers" do
    alias Turpia.Transfers.Transfer

    import Turpia.TransfersFixtures

    @invalid_attrs %{
      amount: "null"
    }

    test "list_transfers/0 returns all transfers" do
      transfer = transfer_fixture()
      assert Transfers.list_transfers() == [transfer]
    end

    test "get_transfer!/1 returns the transfer with given id" do
      transfer = transfer_fixture()
      assert Transfers.get_transfer!(transfer.id) == transfer
    end

    test "create_transfer/1 with valid data creates a transfer" do
      valid_attrs = %{
        amount: 1,
        currency: "PLN",
        debitor: "kieszen"
      }

      assert {:ok, %Transfer{} = transfer} = Transfers.create_transfer(valid_attrs)
    end

    test "create_transfer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Transfers.create_transfer(@invalid_attrs)
    end

    test "update_transfer/2 with valid data updates the transfer" do
      transfer = transfer_fixture()
      update_attrs = %{}

      assert {:ok, %Transfer{} = transfer} = Transfers.update_transfer(transfer, update_attrs)
    end

    test "update_transfer/2 with invalid data returns error changeset" do
      transfer = transfer_fixture()
      assert {:error, %Ecto.Changeset{}} = Transfers.update_transfer(transfer, @invalid_attrs)
      assert transfer == Transfers.get_transfer!(transfer.id)
    end

    test "delete_transfer/1 deletes the transfer" do
      transfer = transfer_fixture()
      assert {:ok, %Transfer{}} = Transfers.delete_transfer(transfer)
      assert_raise Ecto.NoResultsError, fn -> Transfers.get_transfer!(transfer.id) end
    end

    test "change_transfer/1 returns a transfer changeset" do
      transfer = transfer_fixture()
      assert %Ecto.Changeset{} = Transfers.change_transfer(transfer)
    end
  end
end
