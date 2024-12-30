defmodule ErikoIkedaKayWeb.Controllers.TagsHTML do
  use ErikoIkedaKayWeb, :html

  alias ErikoIkedaKayWeb.Templates.Pages

  def index(assigns) do
    ~H"""
    <Pages.tags {assigns} />
    """
  end

  def show(assigns) do
    ~H"""
    <Pages.tag {assigns} />
    """
  end
end
