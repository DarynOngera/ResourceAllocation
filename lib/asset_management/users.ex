defmodule AssetManagement.Users do
  alias AssetManagement.Data

  def list_users() do
    Data.users()
  end 
end
