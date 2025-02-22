defmodule ErikoIkedaKayDevServer.Router do
  @moduledoc false
  use Plug.Router, init_mode: :runtime

  require Logger

  @config :eriko_ikeda_kay
          |> Application.compile_env!(:ssg)
          |> Map.new()

  @not_found ~s'''
  <!DOCTYPE html><html lang="en"><head></head><body>Not Found</body></html>
  '''

  plug :recompile
  plug :rerender

  plug ErikoIkedaKayDevServer.Page

  plug Plug.Static,
    at: "/",
    from: @config.outdir,
    cache_control_for_etags: "no-cache"

  plug :match
  plug :dispatch

  get "/ws/index.html" do
    conn
    |> WebSockAdapter.upgrade(ErikoIkedaKayDevServer.Websocket, [],
      timeout: 60_000
    )
    |> halt()
  end

  match _ do
    Logger.error("File not found: #{conn.request_path}")

    send_resp(conn, 404, @not_found)
  end

  defp recompile(conn, _) do
    if conn.request_path != "/ws" do
      WebDevUtils.CodeReloader.reload()
    end

    conn
  end

  defp rerender(conn, _) do
    if conn.request_path != "/ws" do
      Mix.Task.rerun("eriko_ikeda_kay_ssg.build", ["--out", @config.outdir])
    end

    conn
  end
end
