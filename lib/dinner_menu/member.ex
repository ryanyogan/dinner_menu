defmodule DinnerMenu.Member do
  alias __MODULE__

  @type t() :: %Member{
          id: String.t(),
          name: String.t(),
          age: number(),
          favorite_items: [Item.t()]
        }

  defstruct [
    :id,
    :name,
    :age,
    :favorite_items
  ]
end
