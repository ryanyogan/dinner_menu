defmodule DinnerMenu.Meal.Cache do
  alias DinnerMenu.Repo.Cache

  @behaviour Cache

  def child_spec(opts) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [opts]},
      type: :worker,
      restart: :permanent,
      shutdown: 500
    }
  end

  @impl Cache
  def table_name, do: :meals

  @impl Cache
  def start_link(_args) do
    GenServer.start_link(Cache, __MODULE__, name: __MODULE__)
  end
end
