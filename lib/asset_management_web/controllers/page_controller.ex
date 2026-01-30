defmodule AssetManagementWeb.PageController do
  use AssetManagementWeb, :controller

  def home(conn, _params) do
    redirect(conn, to: ~p"/users")
  end
end
