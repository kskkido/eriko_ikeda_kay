defmodule ErikoIkedaKay.Ecto.Types.URI do
  use Ecto.Type

  # The underlying database type
  def type, do: :string

  # Cast input into a %URI{} struct
  def cast(%URI{} = uri), do: {:ok, uri}

  def cast(uri) when is_binary(uri) do
    case URI.parse(uri) do
      %URI{} = parsed_uri -> {:ok, parsed_uri}
      _ -> :error
    end
  end

  def cast(_), do: :error

  # Dump the %URI{} struct into a string for storage
  def dump(%URI{} = uri), do: {:ok, URI.to_string(uri)}
  def dump(_), do: :error

  # Load the string from the database into a %URI{} struct
  def load(uri) when is_binary(uri) do
    case URI.parse(uri) do
      %URI{} = parsed_uri -> {:ok, parsed_uri}
      _ -> :error
    end
  end

  def load(_), do: :error
end
