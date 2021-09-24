defmodule DinnerMenu.Repo do
  alias DinnerMenu.{Meal, Item, Member}

  @type entity_types :: Meal.t() | Item.t() | Member.t()

  @callback all(Meal | Item | Member) :: {:ok, [entity_types()]} | {:error, term}
  @callback get(Meal | Item | Member, String.t()) :: {:ok, entity_types()} | {:error, term}

  @adapter Application.get_env(:dinner_menu, __MODULE__)[:adapter]

  def meals, do: @adapter.all(Meal)
  def items, do: @adapter.all(Item)
  def members, do: @adapter.all(Member)

  def get_meal(id), do: @adapter.get(Meal, id)
  def get_item(id), do: @adapter.get(Item, id)
  def get_member(id), do: @adapter.get(Member, id)
end
