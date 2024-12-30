defmodule ErikoIkedaKayWeb.Plugs.EnsureProfile do
  import Plug.Conn

  alias ErikoIkedaKay.Contents

  def init(default), do: default

  def call(
        %{
          assigns: %{
            profile: %Contents.ProfileV2{}
          }
        } = conn,
        _default
      ) do
    conn
  end

  def call(conn, _default) do
    assign(conn, :profile, Contents.get_profile_v2())
  end
end
