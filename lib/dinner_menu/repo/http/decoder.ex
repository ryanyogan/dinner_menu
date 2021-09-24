defmodule DinnerMenu.Repo.Http.Decoder do
  @moduledoc false

  alias DinnerMenu.{Meal, Item, Member}

  def decode(response) when is_list(response) do
    Enum.map(response, &decode/1)
  end

  def decode(%{
        "id" => id,
        "fields" =>
          %{
            "Pickle Approved" => pickle_approved
          } = fields
      }) do
    %Meal{
      id: id,
      name: Map.get(fields, "Name", ""),
      date: Date.from_iso8601!(Map.get(fields, "Date")),
      menu_items: Map.get(fields, "Menu Items", []),
      inventory_items: Map.get(fields, "inventory_items", []),
      members: Map.get(fields, "members", []),
      attendees: Map.get(fields, "Attendees", []),
      pickle_approved: pickle_approved
    }
  end

  def decode(%{
        "id" => id,
        "fields" =>
          %{
            "Storage Area" => storage_area
          } = fields
      }) do
    %Item{
      id: id,
      inventory_item: Map.get(fields, "Inventory Items", ""),
      storage_area: storage_area,
      category: Map.get(fields, "Category", "")
    }
  end

  def decode(%{
        "id" => id,
        "fields" =>
          %{
            "Age" => age
          } = fields
      }) do
    %Member{
      id: id,
      name: Map.get(fields, "Name", ""),
      age: age,
      favorite_items: Map.get(fields, "Favorite Items", [])
    }
  end
end
