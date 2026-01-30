defmodule AssetManagementWeb.AllocationController do
  use AssetManagementWeb, :controller
  alias AssetManagement.Allocations

  def index(conn, params) do
    case Map.get(params, "action") do
      "list" ->
        allocations = Allocations.list_allocations()
        render(conn, :index, result: allocations)
      "get" ->
        id = String.to_integer(params["user_id"])
        allocation = Allocations.get_allocation(id)
        render(conn, :index, result: allocation)
      "getper" ->
        id = String.to_integer(params["user_id"])
        user_allocation = Allocations.get_user_allocation(id)
        render(conn, :index, result: user_allocation)
      "allocate" ->
        resource_id = String.to_integer(params["resource_id"])
        user_id = String.to_integer(params["user_id"])
        new_allocation = Allocations.create_allocation(user_id, resource_id)
        render(conn, :index, result: new_allocation)
        |> put_flash(:info, "Created Successfully")
      _ -> 
        render(conn, :index, result: nil)
    end
  end
end

