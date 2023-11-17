defmodule Turpia.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Turpia.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Turpia.PubSub},
      # Start Finch
      {Finch, name: Turpia.Finch}
      # Start a worker by calling: Turpia.Worker.start_link(arg)
      # {Turpia.Worker, arg}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Turpia.Supervisor)
  end
end
