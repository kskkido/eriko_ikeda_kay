defmodule ErikoIkedaKay.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    dev_server? = Application.get_env(:eriko_ikeda_kay, :dev_server?, false)

    children =
      Enum.concat([
        if(dev_server?, do: [ErikoIkedaKayDevServer.Supervisor], else: [])
      ])

    opts = [strategy: :one_for_one, name: ErikoIkedaKay.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
