defmodule AssetManagementWeb.ResourceController do 
  use AssetManagementWeb, :controller
  alias AssetManagement.Resources
  
  def index(conn, params) do
    case Map.get(params, "action") do
      "list" -> 
        resources = Resources.list_resources()
        render(conn, :index, result: resources)
        
      "get" ->
        id = String.to_integer(params["id"])
        case Resources.get_resource(id) do
          nil ->
            conn
            |> put_flash(:error, "Resource not found")
            |> render(:index, result: nil)
          resource ->
            render(conn, :index, result: resource)
        end
        
      "create" ->
        attrs = %{
          name: params["name"],
          type: params["type"]
        }
        new_resource = Resources.create(attrs)
        conn
        |> put_flash(:info, "Resource created successfully")
        |> render(:index, result: new_resource)
        
      "update" ->
        id = parse_id(params["id"])
        attrs = %{id: id}
        attrs = if params["name"], do: Map.put(attrs, :name, params["name"]), else: attrs
        attrs = if params["type"], do: Map.put(attrs, :type, params["type"]), else: attrs
        
        case Resources.update(attrs) do
          nil ->
            conn
            |> put_flash(:error, "Resource not found")
            |> render(:index, result: nil)
          updated ->
            conn
            |> put_flash(:info, "Resource updated successfully")
            |> render(:index, result: updated)
        end
        
      "delete" ->
        id = parse_id(params["id"])
        case Resources.delete(id) do
          nil ->
            conn
            |> put_flash(:error, "Resource not found")
            |> render(:index, result: nil)
          deleted ->
            conn
            |> put_flash(:info, "Resource deleted successfully")
            |> render(:index, result: deleted)
        end
        
      _ -> 
        conn
        |> put_flash(:error, "Invalid action")
        |> render(:index, result: nil)
    end
  end

  defp parse_id(id) when is_integer(id), do: id
  defp parse_id(id) when is_binary(id), do: String.to_integer(id)
  defp parse_id(_), do: nil
end
