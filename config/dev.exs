import Config

# Configures the endpoint
config :eriko_ikeda_kay, ErikoIkedaKayWeb.Endpoint,
  # Binding to loopback ipv4 address prevents access from other machines.
  # Change to `ip: {0, 0, 0, 0}` to allow access from other machines.
  http: [ip: {127, 0, 0, 1}, port: 4900],
  check_origin: false,
  code_reloader: true,
  debug_errors: true,
  secret_key_base:
    "Bl/tuZQ7Owg0HyIjHlz+c4ZEV5X1xxOajASLS+3m6cYDpFGJyQuIza7B4fhxmlZA",
  watchers: [
    npm: [
      "run",
      "build:dev:watch",
      cd: Path.expand("../assets", __DIR__)
    ]
  ],
  live_reload: [
    patterns: [
      ~r"priv/static/(?!uploads/).*(js|css|png|jpeg|jpg|gif|svg|ico|tff)$",
      ~r"priv/gettext/.*(po)$",
      ~r"lib/eriko_ikeda_kay_web/(controllers|components|templates)/.*(ex|heex)$"
    ]
  ]
