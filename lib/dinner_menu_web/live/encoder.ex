defmodule DinnerMenuWeb.LiveEncoder do
  alias DinnerMenu.Item

  def items(items) do
    Enum.map(items, &encode/1)
  end

  def encode(%Item{} = item) do
    Map.take(item, [:id, :inventory_items, :storage_area, :category, :carb_count])
  end
end
