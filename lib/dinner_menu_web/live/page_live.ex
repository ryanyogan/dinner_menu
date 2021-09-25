defmodule DinnerMenuWeb.PageLive do
  use DinnerMenuWeb, :live_view

  alias DinnerMenuWeb.LiveEncoder

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket |> assign_socket()}
  end

  def get_items(menu_items) do
    Enum.map(menu_items, &fetch_item/1)
  end

  defp assign_socket(socket) do
    case fetch_meals() do
      {:ok, meals} ->
        socket
        |> assign(:page_title, "Dinner!")
        |> assign(:meals, meals)
        |> put_flash(:error, nil)

      _ ->
        socket
        |> assign(:page_title, "Dinner!")
        |> assign(:meals, nil)
        |> put_flash(:error, "Error fetching meals")
    end
  end

  defp fetch_meals do
    with {:ok, meals} <- DinnerMenu.meals() do
      meals =
        meals
        |> Enum.sort_by(& &1.date)

      # |> LiveEncoder.meals()

      {:ok, meals}
    end
  end

  defp fetch_item(id) do
    case DinnerMenu.get_item(id) do
      {:ok, item} ->
        item
        |> LiveEncoder.encode()

      reason ->
        {:error, reason}
    end
  end

  def display_day(date), do: date.day

  def day_of_week(date) do
    mapping = %{
      1 => "M",
      2 => "T",
      3 => "W",
      4 => "T",
      5 => "F",
      6 => "S",
      7 => "S"
    }

    day = Date.day_of_week(date)
    mapping[day] || ""
  end

  def is_today?(%Date{} = date), do: Date.utc_today().day == date.day
end
