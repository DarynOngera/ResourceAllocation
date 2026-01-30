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
    time = NaiveDateTime.local_now() |> NaiveDateTime.truncate(:second)
    [
      %{
        id: 1,
        user: "Daryn Ongera", 
        resource: "Lenovo",
        resource_type: "hardware",
        user_id: 1, 
        resource_id: 1,
        allocated_at: time 
      }
    ]
  end
end
