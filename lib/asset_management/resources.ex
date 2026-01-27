defmodule AssetManagement.Resources do
  alias AssetManagement.Data

  def start_link(_opts \\ []) do
    Agent.start_link(fn -> Data.resources() end, name: __MODULE__ )
  end

  def list_resources() do
    # Agent.get(__MODULE__, & &1)
    Data.resources()
  end

  def get_resource(id) do
    list = Data.resources()
    Enum.find(list, &(&1.id == id) )
  end

  def create() do
    list = Data.resources()
    id = next_id(list)

    new_resource = %{id: id, name: "Macbook", type: "Hardware"}
    
    list ++ [new_resource]


  end
  
  def next_id(list) do 
    list
    |> Enum.map(& &1.id)
    |> Enum.max(fn -> 0 end)
    |> Kernel.+(1)
  end
end
