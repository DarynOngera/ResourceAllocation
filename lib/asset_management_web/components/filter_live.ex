defmodule AssetManagementWeb.FilterLive do
  use AssetManagementWeb, :live_view 
  alias AssetManagement.Users


  @impl true
  def mount(_params, _session, socket) do
    all_users = Users.list_users()
    {:ok,
      socket
      |> assign(:all_users, all_users)
      |> assign(:filtered_users, all_users)
      |> assign(:search_query, "")
      |> assign(:result, all_users)}
  end

  @impl true
  def handle_event("search", %{"query" => query}, socket) do
    filtered = filter_users(socket.assigns.all_users, query)
    {:noreply, 
      socket
      |> assign(:search_query, query)
      |> assign(:filtered_users, filtered)
      |> assign(:result, filtered)
    }
  end

  defp filter_users(users, "" ), do: users
  defp filter_users(users, query) do
    query_lower = String.downcase(query)
    Enum.filter(users, fn user ->
      String.contains?(String.downcase(user.name), query_lower)
    end)
  end
end
