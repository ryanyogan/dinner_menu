defmodule DinnerMenu.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      DinnerMenuWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: DinnerMenu.PubSub},
      # Start the Endpoint (http/https)
      DinnerMenuWeb.Endpoint
      # Start a worker by calling: DinnerMenu.Worker.start_link(arg)
      # {DinnerMenu.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: DinnerMenu.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    DinnerMenuWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
