defmodule AssetManagement.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      AssetManagement.Resources,
      AssetManagement.Users,
      AssetManagement.Allocations,
      AssetManagementWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:asset_management, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: AssetManagement.PubSub},
      # Start a worker by calling: AssetManagement.Worker.start_link(arg)
      # {AssetManagement.Worker, arg},
      # Start to serve requests, typically the last entry
      AssetManagementWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: AssetManagement.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    AssetManagementWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
