import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :turpia, Turpia.Repo,
  database: Path.expand("../turpia_test.db", Path.dirname(__ENV__.file)),
  pool_size: 5,
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :turpia_web, TurpiaWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "5FrzQqoiZSdcjC/tnaXIMAvLnF4Ud9kwTxi+KScM5VQDUcXXKiRwS8okeyDN74Yp",
  server: false

# Print only warnings and errors during test
config :logger, level: :warning

# In test we don't send emails.
config :turpia, Turpia.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
