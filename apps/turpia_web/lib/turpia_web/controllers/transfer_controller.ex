defmodule TurpiaWeb.TransferController do
  use TurpiaWeb, :controller

  alias Turpia.Transfers
  alias Turpia.Transfers.Transfer

  action_fallback TurpiaWeb.FallbackController

  def index(conn, _params) do
    transfers = Transfers.list_transfers()
    render(conn, :index, transfers: transfers)
  end

  def create(conn, %{"transfer" => transfer_params}) do
    with {:ok, %Transfer{} = transfer} <- Transfers.create_transfer(transfer_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/transfers/#{transfer}")
      |> render(:show, transfer: transfer)
    end
  end

  def show(conn, %{"id" => id}) do
    transfer = Transfers.get_transfer!(id)
    render(conn, :show, transfer: transfer)
  end

  def update(conn, %{"id" => id, "transfer" => transfer_params}) do
    transfer = Transfers.get_transfer!(id)

    with {:ok, %Transfer{} = transfer} <- Transfers.update_transfer(transfer, transfer_params) do
      render(conn, :show, transfer: transfer)
    end
  end

  def delete(conn, %{"id" => id}) do
    transfer = Transfers.get_transfer!(id)

    with {:ok, %Transfer{}} <- Transfers.delete_transfer(transfer) do
      send_resp(conn, :no_content, "")
    end
  end
end
