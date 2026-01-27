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

  def create(attrs) do
    Agent.get_and_update(__MODULE__, fn current_list ->
    id = next_id(current_list)
    new_list = Map.put(attrs, :id, id)

    updated_list = current_list ++ [new_list] 
    {new_list, updated_list}
    end)
  end

  def delete() do
    Agent.get_and_update(__MODULE__, fn current_list ->
      id = 1
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
