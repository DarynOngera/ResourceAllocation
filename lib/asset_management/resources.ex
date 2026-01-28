defmodule AssetManagement.Resources do
  alias AssetManagement.Data

  def child_spec(opts) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [opts]}
    }
  end

  def start_link(_opts \\ []) do
    Agent.start_link(fn -> Data.resources() end, name: __MODULE__ )
  end

  def list_resources() do
    Agent.get(__MODULE__, fn x ->
      x
      |> Enum.sort_by(&(&1.id), :asc)
    end )
  end

  def get_resource(id) do
    Agent.get(__MODULE__, fn list -> Enum.find(list, &(&1.id == id)) end)
    #Enum.find(list, &(&1.id == id) )
  end

  def create(attrs) do
    Agent.get_and_update(__MODULE__, fn current_list ->
    id = next_id(current_list)
    new_map = Map.put(attrs, :id, id) 
    {new_map, [new_map | current_list]}
    end)
  end

  def delete(id) do
    Agent.get_and_update(__MODULE__, fn current_list ->
      case Enum.find(current_list,fn list -> list.id == id end) do
        nil -> current_list
        item -> updated_list = current_list -- [item]
          {updated_list, updated_list}
      end
    end)
  end

  def update(attrs) do
    Agent.get_and_update(__MODULE__, fn current_list ->
     updated_list = Enum.map(current_list, fn x ->
        if x.id == attrs.id do
          Map.merge(x, attrs)
        else
          x
        end
      end)

      updated_item = Enum.find(updated_list, &(&1.id == attrs.id))
      {updated_item, updated_list}
    end)
end
  
  def next_id(list) do 
    list
    |> Enum.map(& &1.id)
    |> Enum.max()
    |> Kernel.+(1)
  end
end
