defmodule Turpia.IOTest do
  use ExUnit.Case
  doctest Turpia.IO

  setup do
    # Explicitly get a connection before each test
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Turpia.Repo)
  end

  test "puts the csv data to database" do
    file_path = Path.expand("./test/assets/in.csv")
    assert Turpia.IO.csv_to_db(file_path) == :ok
    assert Turpia.IO.get_sources()
    assert length(Turpia.IO.get_transfers()) == 7
  end
end
