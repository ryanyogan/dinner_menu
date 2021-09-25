defmodule DinnerMenu.Repo.Cache.Synchronizer do
  alias DinnerMenu.Repo.Cache

  use GenServer

  @refresh_interval :timer.seconds(5)

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts)
  end

  @impl GenServer
  def init(opts) do
    cache = Keyword.fetch!(opts, :cache)

    send(self(), :sync)

    {:ok, cache}
  end

  @impl GenServer
  def handle_info(:sync, cache) do
    with {:ok, items} <- apply(cache, :fetch_fn, []).() do
      Cache.set_all(cache, items)
    end

    schedule()

    {:noreply, cache}
  end

  defp schedule() do
    Process.send_after(self(), :sync, @refresh_interval)
  end
end
