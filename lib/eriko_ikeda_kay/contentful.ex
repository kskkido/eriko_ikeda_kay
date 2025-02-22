defmodule ErikoIkedaKay.Contentful do
  alias ErikoIkedaKay.Contentful.Client

  def list_assets() do
    Req.new(
      method: :get,
      url: "assets"
    )
    |> Client.send!()
    |> Map.fetch!("items")
  end

  def list_entries(
        %{
          content_type: content_type
        } = params
      ) do
    query =
      URI.encode_query(%{
        content_type: content_type,
        locale: Map.get(params, :locale, :en)
      })

    Req.new(
      method: :get,
      url: "entries?#{query}"
    )
    |> Client.send!()
    |> Map.fetch!("items")
  end
end
