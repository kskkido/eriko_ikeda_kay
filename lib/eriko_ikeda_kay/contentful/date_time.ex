defmodule ErikoIkedaKay.Contentful.DateTime.Parser do
  import NimbleParsec

  date =
    utf8_string([?0..?9], 4)
    |> string("-")
    |> utf8_string([?0..?9], 2)
    |> string("-")
    |> utf8_string([?0..?9], 2)

  hh_mm =
    utf8_string([?0..?9], 2)
    |> string(":")
    |> utf8_string([?0..?9], 2)

  hh_mm_ss =
    utf8_string([?0..?9], 2)
    |> string(":")
    |> utf8_string([?0..?9], 2)
    |> string(":")
    |> utf8_string([?0..?9], 2)

  defparsec(
    :parse_hh_mm_date,
    date
    |> string("T")
    |> concat(hh_mm)
    |> reduce({List, :wrap, []})
    |> optional(
      string("+")
      |> concat(hh_mm)
      |> reduce({List, :wrap, []})
    ),
    debug: true
  )

  defparsec(
    :parse_hh_mm_ss_date,
    date
    |> string("T")
    |> concat(hh_mm_ss)
    |> optional(
      string("+")
      |> concat(hh_mm)
    ),
    debug: true
  )
end

defmodule ErikoIkedaKay.Contentful.DateTime do
  alias ErikoIkedaKay.Contentful.DateTime.Parser

  def from_iso8601(str) do
    case pad_iso8601(str) do
      {:ok, padded} -> DateTime.from_iso8601(padded)
      _ -> DateTime.from_iso8601(str)
    end
  end

  def pad_iso8601(str) do
    case Parser.parse_hh_mm_ss_date(str) do
      {:ok, input, _, _, _, _} ->
        "#{input}"

      _ ->
        case Parser.parse_hh_mm_date(str) do
          {:ok, input, _, _, _, _} ->
            case input do
              [date_time, offset] -> {:ok, "#{date_time}:00#{offset}"}
              [date_time] -> {:ok, "#{date_time}:00"}
            end

          _ ->
            {:error, :invalid_format}
        end
    end
  end
end
