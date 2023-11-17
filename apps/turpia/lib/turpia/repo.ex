defmodule Turpia.Repo do
  use Ecto.Repo,
    otp_app: :turpia,
    adapter: Ecto.Adapters.SQLite3
end
