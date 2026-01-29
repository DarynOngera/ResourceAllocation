defmodule AssetManagement.Allocations do
  alias AssetManagement.Data
  alias AssetManagement.Resources
  alias AssetManagement.Users

  def child_spec(opts) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [opts]}
    }
  end

  def start_link(_opts \\ []) do
    Agent.start_link(fn -> Data.allocations() end, name: __MODULE__)
  end

  def list_allocations() do
    Agent.get(__MODULE__, fn list -> 
      list
      |> Enum.sort_by(&(&1.id), :asc)
    end)
    # Data.allocations()
  end


  def get_allocation(id) do
    Agent.get(__MODULE__, fn list -> Enum.find(list, &(&1.id == id)) end)
  end

  def get_user_allocation(user_id) do
    Agent.get(__MODULE__, fn list -> Enum.filter(list, &(&1.user_id == user_id)) end)
  end

  def create_allocation(user_id, resource_id) do
    case verify_resource(resource_id) do 
      {:ok, _} ->
        Agent.get_and_update(__MODULE__, fn current_list ->
          id = next_id(current_list)
          resource = Enum.find(Resources.list_resources(), &(&1.id == resource_id))
          user = Enum.find(Users.list_users(), &(&1.id == user_id))
          attrs = %{user: user.name, resource: resource.name, user_id: user.id, resource_id: resource.id}
          new_allocation = Map.put(attrs, :id, id)
          {new_allocation, [new_allocation | current_list]}
        end)
      {:error, _} -> "resource not found"
    end
  end

  

  def delete(id) do
    Agent.get_and_update(__MODULE__, fn current_list -> 
      case Enum.find(current_list, &(&1.id == id)) do
        nil -> {nil, current_list}
        item -> updated_list = current_list -- [item]
          {updated_list, updated_list}
      end
    end)
  end

  def verify_resource(resource_id) do
    case Resources.get_resource(resource_id) do
      nil -> {:error, "Resource not found"}
      resource -> {:ok, resource}
    end
  end

  def next_id(list) do 
    list
    |> Enum.map(& &1.id)
    |> Enum.max()
    |> Kernel.+(1)
  end

end
