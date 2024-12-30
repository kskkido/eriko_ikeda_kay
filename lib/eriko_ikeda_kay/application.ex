defmodule ErikoIkedaKay.Application do
  @moduledoc false

  use Application

  import Cachex.Spec

  @impl true
  def start(_type, _args) do
    children = [
      {Cachex,
       [
         :eriko_ikeda_kay,
         [
           expiration:
             expiration(
               default: :timer.hours(1),
               interval: :timer.hours(1),
               lazy: true
             )
         ]
       ]},
      # {Goth,
      # name: ErikoIkedaKay.Goth,
      # prefetch: :sync,
      # source: {
      #   :service_account,
      #   :eriko_ikeda_kay
      #   |> Application.fetch_env!(:google)
      #   |> Keyword.fetch!(:credentials_json)
      #   |> Jason.decode!(),
      #   claims: %{
      #     "sub" => "no-reply@kskkido.com",
      #     "scope" => "https://www.googleapis.com/auth/cloud-platform"
      #   }
      # }},
      {Phoenix.PubSub, name: ErikoIkedaKayWeb.PubSub},
      ErikoIkedaKayWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: ErikoIkedaKay.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
