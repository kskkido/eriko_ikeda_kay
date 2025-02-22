defmodule ErikoIkedaKayDevServer.Server do
  @moduledoc false

  def child_spec(_) do
    Supervisor.child_spec(
      {Bandit, scheme: :http, plug: ErikoIkedaKayDevServer.Router, port: 4999},
      []
    )
  end
end
