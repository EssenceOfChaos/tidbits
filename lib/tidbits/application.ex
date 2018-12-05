defmodule Tidbits.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do

    children = [
      Tidbits.Repo,
      TidbitsWeb.Endpoint,
      TidbitsWeb.Presence
      # Starts a worker by calling: Tidbits.Worker.start_link(arg)
      # {Tidbits.Worker, arg},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Tidbits.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    TidbitsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
