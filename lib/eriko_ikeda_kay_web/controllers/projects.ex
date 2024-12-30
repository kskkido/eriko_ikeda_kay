defmodule ErikoIkedaKayWeb.Controllers.Projects do
  use ErikoIkedaKayWeb, :controller

  alias ErikoIkedaKay.Contents

  def index(conn, _params) do
    conn
    |> assign(:projects, Contents.list_projects_v2())
    |> render(:index)
  end

  def show(conn, %{"slug" => slug}) do
    case Contents.get_project_v2_by_slug(slug) do
      %Contents.ProjectV2{} = project ->
        conn
        |> assign(:project, project)
        |> render(:show)

      _ ->
        conn |> put_status(404) |> halt()
    end
  end
end
