defmodule DinnerMenu.Repo.Cache do
  use GenServer

  alias __MODULE__.Synchronizer

  @callback table_name :: atom()
  @callback start_link(keyword()) :: GenServer.on_start()
  @callback fetch_fn :: fun()

  def all(cache) do
    cache
    |> table_for()
    |> :ets.tab2list()
    |> case do
      values when values != [] ->
        {:ok, Enum.map(values, &elem(&1, 1))}

      _ ->
        {:error, :not_found}
    end
  end

  def get(cache, key) do
    cache
    |> table_for()
    |> :ets.lookup(key)
    |> case do
      [{^key, value} | _] ->
        {:ok, value}

      _ ->
        {:error, :not_found}
    end
  end

  def set_all(cache, items),
    do: GenServer.cast(cache, {:set_all, items})

  def set(cache, id, item),
    do: GenServer.cast(cache, {:set, id, item})

  @impl GenServer
  def init(name) do
    Process.flag(:trap_exit, true)

    name
    |> table_for()
    |> :ets.new([:ordered_set, :protected, :named_table])

    {:ok, pid} = Synchronizer.start_link(cache: name)
    ref = Process.monitor(pid)

    {:ok, %{name: name, synchronizer_ref: ref}}
  end

  @impl GenServer
  def handle_cast({:set_all, items}, %{name: name} = state) when is_list(items) do
    Enum.each(items, &:ets.insert(table_for(name), {&1.id, &1}))

    {:noreply, state}
  end

  @impl GenServer
  def handle_cast({:set, id, item}, %{name: name} = state) do
    name
    |> table_for()
    |> :ets.insert({id, item})

    {:noreply, state}
  end

  @impl GenServer
  def handle_info(
        {:DOWN, ref, :process, _object, _reason},
        %{synchronizer_ref: ref, name: name} = state
      ) do
    {:ok, pid} = Synchronizer.start_link(cache: name)
    ref = Process.monitor(pid)

    {:noreply, %{state | synchronizer_ref: ref}}
  end

  def handle_info({:EXIT, _, _}, state) do
    {:noreply, state}
  end

  defp table_for(name), do: apply(name, :table_name, [])
end
