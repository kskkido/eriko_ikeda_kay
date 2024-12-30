defmodule ErikoIkedaKayWeb.Plugs.EnsureCurrentPath do
  import Plug.Conn

  def init(default), do: default

  def call(
        %{
          request_path: request_path
        } = conn,
        _default
      ) do
    assign(conn, :current_path, request_path)
  end
end
