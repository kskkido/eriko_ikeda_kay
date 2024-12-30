defmodule Extra.Enum do
  def partition_map(xs, map_fn) do
    xs
    |> Enum.map(map_fn)
    |> Enum.reduce({[], []}, fn
      {:error, reason}, {ss, fs} -> {ss, [reason | fs]}
      {:ok, data}, {ss, fs} -> {[data | ss], fs}
    end)
  end
end
