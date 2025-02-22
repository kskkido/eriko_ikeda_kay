defmodule Mix.Tasks.ErikoIkedaKaySsg.Server do
  use Mix.Task

  require Logger

  @impl Mix.Task
  def run(_args) do
    Application.put_env(:eriko_ikeda_kay, :dev_server?, true)
    Code.put_compiler_option(:ignore_module_conflict, true)
    Logger.debug("server started on http://localhost:4999")
    Mix.Task.run("app.start", ["--preload-modules"])
    Mix.Tasks.Run.run(["--no-halt"])
  end
end
