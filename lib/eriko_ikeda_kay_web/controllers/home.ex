defmodule ErikoIkedaKayWeb.Controllers.Home do
  use ErikoIkedaKayWeb, :controller

  alias ErikoIkedaKay.Contents

  def index(conn, _params) do
    conn
    |> assign(:blocks, Contents.list_blocks_v2())
    |> assign(:projects, Contents.list_projects_v2())
    |> render(:index)
  end
end
