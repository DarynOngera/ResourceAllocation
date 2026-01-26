defmodule AssetManagementWeb.PageController do
  use AssetManagementWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
