defmodule DinnerMenu.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      DinnerMenuWeb.Telemetry,
      {Phoenix.PubSub, name: DinnerMenu.PubSub},
      DinnerMenu.Meal.Cache,
      DinnerMenuWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: DinnerMenu.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    DinnerMenuWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
