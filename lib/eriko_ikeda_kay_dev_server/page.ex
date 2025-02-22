defmodule ErikoIkedaKayDevServer.Page do
  @moduledoc false

  @behaviour Plug

  def init(opts) do
    Keyword.merge([default_file: "index.html"], opts)
  end

  def call(conn, default_file: filename) do
    case Path.extname(conn.request_path) do
      "" ->
        %{
          conn
          | request_path:
              String.replace_suffix(conn.request_path, "/", "") <>
                "/#{filename}",
            path_info: conn.path_info ++ [filename]
        }

      _ ->
        conn
    end
  end
end
