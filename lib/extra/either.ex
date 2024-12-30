defmodule Extra.Either do
  def alt(ex, ey) do
    cond do
      elem(ex, 0) == :ok -> ex
      true -> ey
    end
  end

  def sequence(exs) do
    {success, failure} = Extra.Enum.partition_map(exs, & &1)

    if length(failure) > 0 do
      {:error, length(failure)}
    else
      {:ok, success}
    end
  end

  def sequence_map(xs, func) do
    xs
    |> Enum.map(func)
    |> sequence()
  end
end
