import Config

config :eriko_ikeda_kay,
  ssg: [
    outdir: Path.expand("../_dist", __DIR__),
    static_dir: Path.expand("../priv/static", __DIR__)
  ],
  reloader: [
    patterns: [
      ~r"priv/static/(?!uploads/).*(js|css|png|jpeg|jpg|gif|svg|ico|tff)$",
      ~r"priv/gettext/.*(po)$",
      ~r"lib/eriko_ikeda_kay_ssg.ex",
      ~r"lib/eriko_ikeda_kay_ssg/*/.*(ex|heex)$"
    ]
  ]

config :contentful,
  json_library: Jason

config :gettext, :default_locale, "en"

import_config "#{config_env()}.exs"
