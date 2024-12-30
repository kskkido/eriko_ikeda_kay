defmodule ErikoIkedaKayWeb.Controllers.ProjectsHTML do
  use ErikoIkedaKayWeb, :html

  alias ErikoIkedaKayWeb.Templates.Pages

  def index(assigns) do
    ~H"""
    <Pages.projects {assigns} />
    """
  end

  def show(assigns) do
    ~H"""
    <Pages.project {assigns} />
    """
  end
end
