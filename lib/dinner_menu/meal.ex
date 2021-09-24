defmodule DinnerMenu.Meal do
  alias DinnerMenu.{Item, Member}
  alias __MODULE__

  @type t() :: %Meal{
          id: String.t(),
          name: String.t(),
          date: Date.t(),
          menu_items: [Item.t()],
          attendees: [Member.t()],
          pickle_approved: boolean()
        }

  defstruct [
    :id,
    :name,
    :date,
    :menu_items,
    :attendees,
    :pickle_approved
  ]
end
