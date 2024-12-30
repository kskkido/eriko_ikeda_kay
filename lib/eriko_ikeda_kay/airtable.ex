defmodule ErikoIkedaKay.Airtable do
  alias ErikoIkedaKay.Airtable.Client

  def list_records(table_id, _params \\ %{}) do
    case Cachex.get(:eriko_ikeda_kay, table_id) do
      {:ok, nil} ->
        records =
          Req.new(
            method: :get,
            url: table_id
          )
          |> Client.send!()
          |> Map.fetch!("records")

        Cachex.put(:eriko_ikeda_kay, table_id, records)

        records

      {:ok, records} ->
        records
    end
  end
end
