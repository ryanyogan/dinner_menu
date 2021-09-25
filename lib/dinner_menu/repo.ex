defmodule DinnerMenu.Repo do
  alias DinnerMenu.{Meal, Item, Member}
  alias DinnerMenu.Repo.Cache

  @type entity_types :: Meal.t() | Item.t() | Member.t()

  @callback all(Meal | Item | Member) :: {:ok, [entity_types()]} | {:error, term}
  @callback get(Meal | Item | Member, String.t()) :: {:ok, entity_types()} | {:error, term}

  @adapter Application.get_env(:dinner_menu, __MODULE__)[:adapter]

  def meals(skip_cache \\ false)
  def meals(false), do: all(Meal)
  def meals(true), do: @adapter.all(Meal)

  def items(skip_cache \\ false)
  def items(false), do: all(Item)
  def items(true), do: @adapter.all(Item)

  def members(skip_cache \\ false)
  def members(false), do: all(Member)
  def members(true), do: @adapter.all(Member)

  def get_meal(id), do: get(Meal, id)

  # def get_meal(id), do: @adapter.get(Meal, id)

  def get_item(id), do: @adapter.get(Item, id)
  def get_member(id), do: @adapter.get(Member, id)

  defp all(entity) do
    with cache <- cache_for(entity),
         {:error, :not_found} <- Cache.all(cache),
         {:ok, items} <- @adapter.all(entity) do
      Cache.set_all(cache, items)
      {:ok, items}
    end
  end

  defp get(entity, id) do
    with cache <- cache_for(entity),
         {:error, :not_found} <- Cache.get(cache, id),
         {:ok, item} <- @adapter.get(entity, id) do
      Cache.set(cache, id, item)
      {:ok, item}
    end
  end

  defp cache_for(Meal), do: DinnerMenu.Meal.Cache
end
