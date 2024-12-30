defmodule ErikoIkedaKay.Contentful.Client do
  def send(request) do
    config = config()

    response =
      request
      |> Req.merge(
        base_url:
          Path.join([
            config.base_url,
            "/spaces/#{config.space_id}",
            "/environments/#{config.environment}"
          ]),
        auth: {:bearer, config.access_token}
      )
      |> Req.request()

    case response do
      {:ok, response} ->
        case response do
          %{status: 200, body: body} -> {:ok, body}
          _ -> {:error, :unhandled}
        end

      error ->
        error
    end
  end

  def send!(request) do
    {:ok, body} = send(request)
    body
  end

  defp config do
    :eriko_ikeda_kay
    |> Application.fetch_env!(:contentful)
    |> Enum.into(%{})
  end
end
