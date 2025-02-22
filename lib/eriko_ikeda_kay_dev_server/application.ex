defmodule ErikoIkedaKayDevServer.Application do
  @moduledoc false

  use Application

  require Logger

  @impl true
  def start(_type, _args) do
    children = []

    opts = [strategy: :one_for_one, name: ErikoIkedaKayDevServer.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
