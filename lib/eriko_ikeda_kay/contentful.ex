defmodule ErikoIkedaKay.Contentful do
  alias ErikoIkedaKay.Contentful.Client

  def list_assets() do
    cache_id = "contentful/assets"

    case Cachex.get(:eriko_ikeda_kay, cache_id) do
      {:ok, nil} ->
        result =
          Req.new(
            method: :get,
            url: "assets"
          )
          |> Client.send!()
          |> Map.fetch!("items")

        Cachex.put(:eriko_ikeda_kay, cache_id, result)

        result

      {:ok, records} ->
        records
    end
  end

  def list_entries_by_content_type(content_type) do
    cache_id = "contentful/entries/#{content_type}"

    case Cachex.get(:eriko_ikeda_kay, cache_id) do
      {:ok, nil} ->
        query =
          URI.encode_query(%{
            content_type: content_type
          })

        result =
          Req.new(
            method: :get,
            url: "entries?#{query}"
          )
          |> Client.send!()
          |> Map.fetch!("items")

        Cachex.put(:eriko_ikeda_kay, cache_id, result)

        result

      {:ok, records} ->
        records
    end
  end
end
