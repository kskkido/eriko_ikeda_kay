import Config

config :eriko_ikeda_kay,
  build_dir: Path.expand("../dist", __DIR__),
  stage_build_dir: Path.expand("../tmp", __DIR__)

config :contentful,
  json_library: Jason

# Configures the endpoint
config :eriko_ikeda_kay, ErikoIkedaKayWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  pubsub_server: ErikoIkedaKayWeb.PubSub

import_config "#{config_env()}.exs"
