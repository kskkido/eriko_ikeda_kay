import Config
import Dotenvy

source!(["config/.env.#{config_env()}", System.get_env()])

config :contentful,
  delivery: [
    access_token: env!("CONTENTFUL_ACCESS_TOKEN", :string),
    environment: env!("CONTENTFUL_ENVIRONMENT", :string),
    space_id: env!("CONTENTFUL_SPACE_ID", :string)
    # defaults to `master`
  ]

config :eriko_ikeda_kay,
  airtable: [
    base_url: "https://api.airtable.com/v0",
    access_token: env!("AIRTABLE_ACCESS_TOKEN", :string),
    base_id: env!("AIRTABLE_BASE_ID", :string)
  ],
  contentful: [
    base_url: "https://cdn.contentful.com",
    access_token: env!("CONTENTFUL_ACCESS_TOKEN", :string),
    environment: env!("CONTENTFUL_ENVIRONMENT", :string),
    space_id: env!("CONTENTFUL_SPACE_ID", :string)
  ],
  google: [
    credentials_json: env!("GOOGLE_APPLICATION_CREDENTIALS_JSON", :string)
  ],
  gmail: [
    sender: "no-reply@kskkido.com"
  ]

if System.get_env("PHX_SERVER") do
  config :eriko_ikeda_kay, ErikoIkedaKayWeb.Endpoint, server: true
end

if config_env() == :prod do
  config :eriko_ikeda_kay,
         :dns_cluster_query,
         env!("DNS_CLUSTER_QUERY", :string, nil)

  config :eriko_ikeda_kay, ErikoIkedaKayWeb.Endpoint,
    url: [host: env!("PHX_HOST", :string), port: 443, scheme: "https"],
    http: [
      ip: {0, 0, 0, 0, 0, 0, 0, 0},
      port: env!("PORT", :integer)
    ],
    secret_key_base: env!("SECRET_KEY_BASE", :string)
end
