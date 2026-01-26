defmodule AssetManagement.Allocations do
  alias AssetManagement.Data

  def list_allocations() do
    Data.resources()
    |> Enum.at(0) 
  end
end
