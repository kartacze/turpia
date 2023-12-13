defmodule Turpia.TransfersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Turpia.Transfers` context.
  """

  @doc """
  Generate a transfer.
  """
  def transfer_fixture(attrs \\ %{}) do
    {:ok, transfer} =
      attrs
      |> Enum.into(%{

      })
      |> Turpia.Transfers.create_transfer()

    transfer
  end
end
