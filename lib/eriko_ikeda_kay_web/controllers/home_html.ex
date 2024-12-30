defmodule ErikoIkedaKayWeb.Controllers.HomeHTML do
  use ErikoIkedaKayWeb, :html

  alias ErikoIkedaKayWeb.Templates.Pages

  def index(assigns) do
    ~H"""
    <Pages.home {assigns} />
    """
  end
end
