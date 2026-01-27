defmodule AssetManagement.Data do
  def resources do
    [
      %{id: 1, name: "Lenovo", type: "hardware"},
      %{id: 2, name: "MSI Monitor", type: "hardware"}
    ]
  end

  def users do 
    [
      %{id: 1, name: "Daryn Ongera"}
    ]
  end
end
