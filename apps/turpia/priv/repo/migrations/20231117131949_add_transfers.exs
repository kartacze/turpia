defmodule Turpia.Repo.Migrations.AddTransfers do
  use Ecto.Migration

  def change do
    create table(:transfer) do
      add(:debitor, :string)
      add(:creditor, :string)
      add(:amount, :integer)
      add(:currency, :string)
      add(:source, :string)
      add(:transfer_date, :utc_datetime)

      timestamps(type: :utc_datetime)
    end
  end
end
