defmodule DinnerMenu.Item do
  alias __MODULE__

  @type t() :: %Item{
          id: String.t(),
          inventory_item: String.t(),
          storage_area: String.t(),
          category: String.t(),
          carb_count: String.t()
        }

  defstruct [
    :id,
    :inventory_item,
    :storage_area,
    :category,
    :carb_count
  ]
end
