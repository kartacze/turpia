defmodule Turpia.IO do
  alias Explorer.{DataFrame}
  alias Turpia.Transfers.{Transfer}
  import Ecto.Query, only: [from: 2]

  def csv_to_db(file_path) do
    {:ok, dt} = DataFrame.from_csv(file_path)
    source = Ecto.UUID.generate()
    to_transfers(dt, source) |> to_repo
  end

  defp to_repo({:ok, list}) do
    list |> Enum.each(&Turpia.Repo.insert(&1))
  end

  defp to_transfers(data_frame, source) do
    DataFrame.to_rows(data_frame)
    |> Enum.map(&from_row(&1, source))
    |> return_all_valid
  end

  defp from_row(t, source) do
    [dd, mm, yyyy] = String.split(t["data"], ".")
    {:ok, datetime, 0} = DateTime.from_iso8601("#{yyyy}-#{mm}-#{dd}T15:00:00Z")

    Transfer.changeset(%Transfer{}, %{
      creditor: t["to"],
      debitor: t["from"],
      transfer_date: datetime,
      amount: trunc(t["kwota"] * 100),
      currency: t["currency"],
      source: source
    })
  end

  defp return_all_valid(list) do
    valid =
      list
      |> Enum.all?(fn c -> c.valid? == true end)

    case valid do
      true ->
        {:ok, list}

      _ ->
        {:error, "invalid data", list |> Enum.filter(fn c -> c.valid? == false end)}
    end
  end

  def get_sources() do
    Transfer
    |> Ecto.Query.select([t], t.source)
    |> Ecto.Query.distinct(true)
    |> Turpia.Repo.all()
  end

  def get_transfers_by_source(source) do
    Transfer
    |> Ecto.Query.where(source: ^source)
    |> Turpia.Repo.all()
  end

  def remove_transfers_by_source(source) do
    get_transfers_by_source(source) |> Enum.each(&Turpia.Repo.delete/1)
  end

  def get_transfers() do
    Transfer
    |> Turpia.Repo.all()
    |> Transfer.to_dataframe()
  end
end
