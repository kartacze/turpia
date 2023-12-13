defmodule TurpiaWeb.TransferJSON do
  alias Turpia.Transfers.Transfer

  @doc """
  Renders a list of transfers.
  """
  def index(%{transfers: transfers}) do
    %{data: for(transfer <- transfers, do: data(transfer))}
  end

  @doc """
  Renders a single transfer.
  """
  def show(%{transfer: transfer}) do
    %{data: data(transfer)}
  end

  defp data(%Transfer{} = transfer) do
    %{
      id: transfer.id,
      debitor: transfer.debitor,
      amount: transfer.amount
    }
  end
end
