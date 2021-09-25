defmodule DinnerMenu.Meal.Cache do
  alias DinnerMenu.{Repo, Repo.Cache}

  @behaviour Cache
  @topic "meals"

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

  @impl Cache
  def fetch_fn, do: fn -> Repo.meals(true) end

  @impl Cache
  def topic, do: @topic
end
