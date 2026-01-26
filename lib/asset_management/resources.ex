defmodule AssetManagement.Resources do
  alias AssetManagement.Data

  def list_resources() do
    Data.resources()
  end
end
