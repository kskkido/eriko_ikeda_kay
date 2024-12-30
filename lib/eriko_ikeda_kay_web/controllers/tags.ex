defmodule ErikoIkedaKayWeb.Controllers.Tags do
  use ErikoIkedaKayWeb, :controller

  alias ErikoIkedaKay.Contents

  def index(conn, _params) do
    conn
    |> assign(:tags, Contents.list_project_tags_v2())
    |> render(:index)
  end

  def show(conn, %{"name" => tag_name}) do
    case Contents.get_project_tag_v2_by_name(tag_name) do
      %Contents.ProjectTag{} = tag ->
        conn
        |> assign(:tag, tag)
        |> render(:show)

      _ ->
        conn |> put_status(404) |> halt()
    end
  end
end
