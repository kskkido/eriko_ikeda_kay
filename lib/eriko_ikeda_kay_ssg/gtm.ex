defmodule ErikoIkedaKaySSG.GTM do
  defp config do
    :eriko_ikeda_kay
    |> Application.fetch_env!(:gtm)
    |> Map.new()
  end

  def gtm_container_id do
    config().container_id
  end
end
