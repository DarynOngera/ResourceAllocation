defmodule AssetManagement.Resources do
  alias AssetManagement.Data

  def start_link(_opts \\ []) do
    Agent.start_link(fn -> Data.resources() end, name: __MODULE__ )
  end

  def list_resources() do
    Agent.get(__MODULE__, fn x -> x end )
  end

  def get_resource(id) do
    Agent.get(__MODULE__, fn list -> Enum.find(list, &(&1.id == id)) end)
    #Enum.find(list, &(&1.id == id) )
  end

  def create() do
    Agent.get_and_update(__MODULE__, fn list ->
    id = next_id(list)
    new_resource = %{id: id, name: "Macbook", type: "Hardware"}
    updated_list = list ++ [new_resource]
    {new_resource, updated_list}
    end)
  end

  def delete() do
    Agent.get_and_update(__MODULE__, fn current_list ->
      id = 2
      case Enum.find(current_list,fn list -> list.id == id end) do
        nil -> current_list
        item -> updated_list = current_list -- [item]
          {updated_list, updated_list}
      end
    end)
  end
  
  def next_id(list) do 
    list
    |> Enum.map(& &1.id)
    |> Enum.max(fn -> 0 end)
    |> Kernel.+(1)
  end
end
