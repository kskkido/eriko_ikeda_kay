defmodule ErikoIkedaKayWeb.Controllers.ContactHTML do
  use ErikoIkedaKayWeb, :html

  alias ErikoIkedaKayWeb.Templates.Pages

  def index(assigns) do
    ~H"""
    <Pages.contact {assigns} />
    """
  end

  def message_received(assigns) do
    ~H"""
    <Pages.contact_message_received {assigns} />
    """
  end
end
