defmodule DinnerMenuWeb.PageLive do
  use DinnerMenuWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
