defmodule ErikoIkedaKay.Mailer do
  require Logger
  alias GoogleApi.Gmail.V1.Api.Users
  alias GoogleApi.Gmail.V1.Connection

  def send_email(to, subject, body) do
    sender = sender()

    case Goth.fetch(ErikoIkedaKay.Goth) do
      {:ok, token} ->
        email =
          [
            "From: #{sender}",
            "To: #{to}",
            "Subject: #{subject}",
            "",
            body
          ]
          |> Enum.join("\r\n")
          |> Base.encode64()

        Users.gmail_users_messages_send(
          Connection.new(token.token),
          "me",
          body: %{raw: email}
        )
    end
  end

  def sender() do
    :eriko_ikeda_kay
    |> Application.fetch_env!(:gmail)
    |> Keyword.fetch!(:sender)
  end
end
