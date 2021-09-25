defmodule DinnerMenu.Meal do
  alias DinnerMenu.{Item, Member}
  alias __MODULE__

  @type t() :: %Meal{
          id: String.t(),
          name: String.t(),
          date: Date.t(),
          menu_items: [Item.t()],
          inventory_items: [String.t()],
          attendees: [Member.t()],
          members: [String.t()],
          kids: String.t()
        }

  defstruct [
    :id,
    :name,
    :date,
    :menu_items,
    :inventory_items,
    :members,
    :attendees,
    :kids
  ]
end
