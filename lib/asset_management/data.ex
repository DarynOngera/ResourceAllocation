defmodule AssetManagement.Data do
  def resources do
    [
      %{id: 1, name: "Lenovo", type: "hardware"},
      %{id: 2, name: "MSI Monitor", type: "hardware"}
    ]
  end

  def users do 
    [
      %{id: 1, name: "Daryn Ongera"},
      %{id: 2, name: "Obi Wan"},
      %{id: 3, name: "John Doe"}
    ]
  end

  def allocations do
    [
      %{
        id: 1,
        user: "Daryn Ongera", 
        resource: "Lenovo", 
        user_id: 1, 
        resource_id: 1
      }
    ]
  end
end
