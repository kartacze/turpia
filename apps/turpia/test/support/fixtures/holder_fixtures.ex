defmodule Turpia.HolderFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Turpia.Holder` context.
  """

  @doc """
  Generate a unique wallets name.
  """
  def unique_wallets_name, do: "some name#{System.unique_integer([:positive])}"

  @doc """
  Generate a wallets.
  """
  def wallets_fixture(attrs \\ %{}) do
    {:ok, wallets} =
      attrs
      |> Enum.into(%{
        currency: "some currency",
        name: unique_wallets_name(),
        quantity: 42,
        tens: 42,
        type: "some type"
      })
      |> Turpia.Holder.create_wallets()

    wallets
  end
end
