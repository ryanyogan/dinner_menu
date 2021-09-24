defmodule DinnerMenu.Repo.Http do
  alias __MODULE__.Decoder
  alias DinnerMenu.{Meal, Item, Member, Repo}
  alias Services.Airtable

  @behaviour Repo

  @dinners_table "Dinners"
  @items_table "Items"
  @members_table "Members"

  @impl Repo
  def all(Meal), do: do_all(@dinners_table)
  def all(Item), do: do_all(@items_table)
  def all(Member), do: do_all(@members_table)

  @impl Repo
  def get(Meal, id), do: do_get(@dinners_table, id)
  def get(Item, id), do: do_get(@items_table, id)
  def get(Member, id), do: do_get(@members_table, id)

  defp do_all(table) do
    case Airtable.all(table) do
      {:ok, %{"records" => records}} ->
        {:ok, Decoder.decode(records)}

      {:error, 404} ->
        {:error, :not_found}

      other ->
        other
    end
  end

  defp do_get(table, id) do
    case Airtable.get(table, id) do
      {:ok, response} ->
        IO.inspect(response)

        {:ok, Decoder.decode(response)}

      {:error, 404} ->
        {:error, :not_found}

      other ->
        other
    end
  end
end
