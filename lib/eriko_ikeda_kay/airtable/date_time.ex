defmodule ErikoIkedaKay.Airtable.DateTime.Parser do
  import NimbleParsec

  date =
    utf8_string([?0..?9], 4)
    |> string("-")
    |> utf8_string([?0..?9], 2)
    |> string("-")
    |> utf8_string([?0..?9], 2)

  defparsec(
    :parse_date,
    date,
    debug: true
  )
end

defmodule ErikoIkedaKay.Airtable.DateTime do
  alias ErikoIkedaKay.Airtable.DateTime.Parser

  def from_iso8601(str) do
    case pad_iso8601(str) do
      {:ok, padded} -> DateTime.from_iso8601(padded)
      _ -> DateTime.from_iso8601(str)
    end
  end

  def pad_iso8601(str) do
    case Parser.parse_date(str) do
      {:ok, input, _, _, _, _} ->
        {:ok, "#{input}T00:00:00+09:00"}

      _ ->
        {:error, :invalid_format}
    end
  end
end
