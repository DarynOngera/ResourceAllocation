defmodule AssetManagementWeb.UserController do
  use AssetManagementWeb, :controller
  alias AssetManagement.Users

  def index(conn, params) do
    case Map.get(params, ["action", "query"] ) do
      "list" -> 
        users = Users.list_users()
        render(conn, :index, result: users)

      "get" ->
        id = String.to_integer(params["user_id"])
        user = Users.get_user(id)
        render(conn, :index, result: user)

      "create" ->
        attrs = %{name: params["name"]}
        new_user = Users.create_user(attrs)
        render(conn, :index, result: new_user)
      "update" ->
        id = String.to_integer(params["user_id"])
        attrs = %{id: id}
        attrs = if params["name"], do: Map.put(attrs, :name, params["name"]), else: attrs

        updated = Users.update(attrs)
        render(conn, :index, result: updated)

      "delete" ->
        id = String.to_integer(params["user_id"])
        deleted = Users.delete_user(id)
        render(conn, :index, result: deleted)
      _ -> 
        render(conn, :index, result: nil)

    end
  end
end
