defmodule AssetManagementWeb.ResourceController do 
  use AssetManagementWeb, :controller
  alias AssetManagement.Resources
  
  def index(conn, params) do
    case Map.get(params, "action") do
      "list" -> 
        resources = Resources.list_resources()
        render(conn, :index, result: resources)
        
      "get" ->
        id = String.to_integer(params["resource_id"])
        resource = Resources.get_resource(id)
        render(conn, :index, result: resource)
        
      "create" ->
        attrs = %{
          name: params["name"],
          type: params["type"]
        }
        new_resource = Resources.create(attrs)
        render(conn, :index, result: new_resource)
        
      "update" ->
        id = String.to_integer(params["resource_id"])
        attrs = %{id: id}
        attrs = if params["name"], do: Map.put(attrs, :name, params["name"]), else: attrs
        attrs = if params["type"], do: Map.put(attrs, :type, params["type"]), else: attrs
        
        updated = Resources.update(attrs)
        render(conn, :index, result: updated)
        
      "delete" ->
        id = String.to_integer(params["resource_id"])
        updated = Resources.delete(id)
        render(conn, :index, result: updated)
      _ -> 
        render(conn, :index, result: nil)
    end
  end
end
