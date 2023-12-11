defmodule Turpia.Holder do
  @moduledoc """
  The Holder context.
  """

  import Ecto.Query, warn: false
  alias Turpia.Repo

  alias Turpia.Holder.Wallets

  @doc """
  Returns the list of wallets.

  ## Examples

      iex> list_wallets()
      [%Wallets{}, ...]

  """
  def list_wallets do
    Repo.all(Wallets)
  end

  @doc """
  Gets a single wallets.

  Raises `Ecto.NoResultsError` if the Wallets does not exist.

  ## Examples

      iex> get_wallets!(123)
      %Wallets{}

      iex> get_wallets!(456)
      ** (Ecto.NoResultsError)

  """
  def get_wallets!(id), do: Repo.get!(Wallets, id)

  @doc """
  Creates a wallets.

  ## Examples

      iex> create_wallets(%{field: value})
      {:ok, %Wallets{}}

      iex> create_wallets(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_wallets(attrs \\ %{}) do
    %Wallets{}
    |> Wallets.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a wallets.

  ## Examples

      iex> update_wallets(wallets, %{field: new_value})
      {:ok, %Wallets{}}

      iex> update_wallets(wallets, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_wallets(%Wallets{} = wallets, attrs) do
    wallets
    |> Wallets.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a wallets.

  ## Examples

      iex> delete_wallets(wallets)
      {:ok, %Wallets{}}

      iex> delete_wallets(wallets)
      {:error, %Ecto.Changeset{}}

  """
  def delete_wallets(%Wallets{} = wallets) do
    Repo.delete(wallets)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking wallets changes.

  ## Examples

      iex> change_wallets(wallets)
      %Ecto.Changeset{data: %Wallets{}}

  """
  def change_wallets(%Wallets{} = wallets, attrs \\ %{}) do
    Wallets.changeset(wallets, attrs)
  end
end
