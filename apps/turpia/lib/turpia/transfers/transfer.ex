defmodule Turpia.Transfers.Transfer do
  @moduledoc """
  Documentation for `Turpia.Transfers.Transfer`.
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "transfer" do
    field(:debitor, :string)
    field(:creditor, :string, default: "")
    field(:amount, :integer)
    field(:currency, :string)
    field(:source, :string)
    field(:transfer_date, :utc_datetime, default: DateTime.utc_now(:second))

    timestamps(type: :utc_datetime)
  end

  def changeset(transfer, params \\ %{}) do
    transfer
    |> cast(params, [:amount, :currency, :transfer_date, :creditor, :debitor, :source])
    |> validate_required([:amount, :currency, :debitor, :transfer_date])
  end

  def to_dataframe(transfers) do
    transfers
    |> Enum.map(&Map.drop(&1, [:__meta__, :__struct__, :inserted_at, :updated_at, :id]))
    |> Enum.map(&datetime_to_date(:transfer_date, &1))
  end

  defp datetime_to_date(key, dt) do
    Map.update(dt, key, 0, fn datetime ->
      DateTime.to_date(datetime)
    end)
  end
end
