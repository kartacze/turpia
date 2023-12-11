defmodule Turpia.Repo.Migrations.CreateWallets do
  use Ecto.Migration

  def change do
    create table(:wallets) do
      add :name, :string
      add :type, :string
      add :currency, :string
      add :quantity, :integer
      add :tens, :integer

      timestamps()
    end

    create unique_index(:wallets, [:id])
    create unique_index(:wallets, [:name])
  end
end
