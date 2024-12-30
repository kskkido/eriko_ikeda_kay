defmodule ErikoIkedaKay.Ecto.Types.DateTime do
  use Ecto.Type

  alias ErikoIkedaKay.Airtable
  alias ErikoIkedaKay.Contentful

  def type, do: :utc_datetime

  def cast(%DateTime{} = value), do: {:ok, value}

  def cast(value) when is_binary(value) do
    case Contentful.DateTime.from_iso8601(value) do
      {:ok, date_time, _} ->
        {:ok, date_time}

      _ ->
        case Airtable.DateTime.from_iso8601(value) do
          {:ok, date_time, _} -> {:ok, date_time}
          _ -> :error
        end
    end
  end

  def cast(_), do: :error

  def load(value), do: {:ok, value}

  def dump(value), do: {:ok, value}
end
