defmodule ErikoIkedaKaySSG do
  defmacro __using__(_opts \\ []) do
    quote do
      use Phoenix.Component
      use Gettext, backend: ErikoIkedaKaySSG.Gettext

      import Phoenix.HTML
      import ErikoIkedaKaySSG
    end
  end

  def localize_path(:en, path) do
    case Path.split(path) do
      [] -> "/"
      ["/", "ja" | []] -> "/"
      ["/", "ja" | rest] -> Path.join(["/", Path.join(rest)])
      _ -> path
    end
  end

  def localize_path(:ja, path) do
    case Path.split(path) do
      [] -> "/ja"
      ["/", "ja" | _] -> Path.join(["/", path])
      _ -> Path.join(["/ja", path])
    end
  end

  def subpath?(a, b) do
    case {localize_path(:en, a), localize_path(:en, b)} do
      {"/" = a, b} ->
        a == b

      {a, b} ->
        a_segments = Path.split(a)
        b_segments = Path.split(b)

        length(a_segments) <= length(b_segments) &&
          a_segments
          |> Enum.zip_with(
            b_segments,
            &(&1 == &2 || String.starts_with?(&2, ":"))
          )
          |> Enum.all?()
    end
  end
end
