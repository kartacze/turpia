defmodule Turpia.Holder.Wallets do
  use Ecto.Schema
  import Ecto.Changeset

  schema "wallets" do
    field :name, :string
    field :type, :string
    field :currency, :string
    field :quantity, :integer
    field :tens, :integer

    timestamps()
  end

  @doc false
  def changeset(wallets, attrs) do
    wallets
    |> cast(attrs, [:name, :type, :currency, :quantity, :tens])
    |> validate_required([:name, :type, :currency, :quantity, :tens])
    |> unique_constraint(:name)
  end
end
