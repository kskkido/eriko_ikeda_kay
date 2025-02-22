defmodule ErikoIkedaKayDevServer.Supervisor do
  @moduledoc false

  use Supervisor

  def start_link(args) do
    Supervisor.start_link(__MODULE__, args, name: __MODULE__)
  end

  @impl true
  def init(_args) do
    children =
      Enum.concat([
        [WebDevUtils.FileSystem],
        [WebDevUtils.CodeReloader],
        :eriko_ikeda_kay
        |> Application.get_env(:assets, [])
        |> Enum.map(&{WebDevUtils.Assets, &1}),
        [ErikoIkedaKayDevServer.Server]
      ])

    Supervisor.init(children, strategy: :one_for_one)
  end
end
