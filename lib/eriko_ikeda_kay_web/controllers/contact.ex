defmodule ErikoIkedaKayWeb.Controllers.Contact do
  use ErikoIkedaKayWeb, :controller

  alias ErikoIkedaKay.Contacts.Contact
  alias ErikoIkedaKay.Mailer

  def index(conn, _params) do
    conn
    |> render(:index)
  end

  def post(conn, params) do
    with {:ok, _} <- Contact.validate(%Contact{}, params),
         {:ok, _} <-
           Mailer.send_email("kskkido@gmail.com", "test", "konnichiwa") do
      conn
      |> redirect(to: ~p"/contact/success")
    else
      error ->
        dbg(error)

        conn
        |> put_status(500)
        |> json(%{error: "An unexpected error ocurred"})
    end
  end

  def message_received(conn, _params) do
    conn
    |> render(:message_received)
  end
end
