defmodule TurpiaWeb.TransferControllerTest do
  use TurpiaWeb.ConnCase

  import Turpia.TransfersFixtures

  alias Turpia.Transfers.Transfer

  @create_attrs %{
    debitor: "some debitor",
    amount: 42
  }
  @update_attrs %{
    debitor: "some updated debitor",
    amount: 43
  }
  @invalid_attrs %{debitor: nil, amount: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all transfers", %{conn: conn} do
      conn = get(conn, ~p"/api/transfers")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create transfer" do
    test "renders transfer when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/transfers", transfer: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/transfers/#{id}")

      assert %{
               "id" => ^id,
               "amount" => 42,
               "debitor" => "some debitor"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/transfers", transfer: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update transfer" do
    setup [:create_transfer]

    test "renders transfer when data is valid", %{conn: conn, transfer: %Transfer{id: id} = transfer} do
      conn = put(conn, ~p"/api/transfers/#{transfer}", transfer: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/transfers/#{id}")

      assert %{
               "id" => ^id,
               "amount" => 43,
               "debitor" => "some updated debitor"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, transfer: transfer} do
      conn = put(conn, ~p"/api/transfers/#{transfer}", transfer: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete transfer" do
    setup [:create_transfer]

    test "deletes chosen transfer", %{conn: conn, transfer: transfer} do
      conn = delete(conn, ~p"/api/transfers/#{transfer}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/transfers/#{transfer}")
      end
    end
  end

  defp create_transfer(_) do
    transfer = transfer_fixture()
    %{transfer: transfer}
  end
end
