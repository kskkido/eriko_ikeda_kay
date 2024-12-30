defmodule ErikoIkedaKay.MixProject do
  use Mix.Project

  def project do
    [
      app: :eriko_ikeda_kay,
      version: "0.1.0",
      elixir: "~> 1.17",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases()
    ]
  end

  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {ErikoIkedaKay.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:bandit, "~> 1.5"},
      {:cachex, "~> 4.0"},
      {:contentful, "~> 0.6.0"},
      {:dotenvy, "~> 0.9.0"},
      {:earmark, "~> 1.4.0"},
      {:earmark_parser, "~> 1.4.0"},
      {:ecto_sql, "~> 3.10"},
      {:ecto_ulid_next, "~> 1.0.0"},
      {:gettext, "~> 0.20"},
      {:google_api_gmail, "~> 0.16.0"},
      {:goth, "~> 1.4.5"},
      {:lucide_live_view, "~> 0.1.0"},
      {:nimble_parsec, "~> 1.0"},
      {:phoenix, "~> 1.7.14"},
      {:phoenix_html, "~> 4.1"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:phoenix_live_view, "~> 1.0.0"},
      {:req, "~> 0.5.0"}
    ]
  end

  defp aliases do
    [
      serve: ["cmd --cd dist python3 -m http.server 8000"],
      npm: ["cmd --cd assets npm i"],
      "assets.build": ["cmd --cd assets npm i && npm run build:dev"],
      "assets.build.watch": ["cmd --cd assets npm i && npm run build:dev:watch"],
      "assets.deploy": [
        "cmd --cd assets npm i && npm run build:prod",
        "phx.digest"
      ],
      "assets.lint.fix": [
        "cmd --cd assets npm i && npm run lint:fix"
      ],
      translate: ["gettext.extract --merge --no-fuzzy"]
    ]
  end
end
