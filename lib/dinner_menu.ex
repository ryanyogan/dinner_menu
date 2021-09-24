defmodule DinnerMenu do
  @moduledoc """
  DinnerMenu keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  defdelegate meals, to: DinnerMenu.Repo
  defdelegate members, to: DinnerMenu.Repo
  defdelegate items, to: DinnerMenu.Repo

  defdelegate get_meal(id), to: DinnerMenu.Repo
  defdelegate get_item(id), to: DinnerMenu.Repo
  defdelegate get_member(id), to: DinnerMenu.Repo
end
