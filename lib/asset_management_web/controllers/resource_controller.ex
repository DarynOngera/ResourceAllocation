defmodule AssetManagementWeb.ResourceController do 
  use AssetManagementWeb, :controller
  alias AssetManagement.Resources
  
  def index(conn, _params) do
    resources = Resources.list_resources()
    render(conn, "index.html", resources: resources)
  end
end
