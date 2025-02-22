import Config
import Dotenvy

source!(["config/.env.#{config_env()}", System.get_env()])

config :eriko_ikeda_kay,
  gtm: [
    container_id: "GTM-NV6SMG6G"
  ],
  contentful: [
    base_url: "https://cdn.contentful.com",
    access_token: env!("CONTENTFUL_ACCESS_TOKEN", :string),
    environment: env!("CONTENTFUL_ENVIRONMENT", :string),
    space_id: env!("CONTENTFUL_SPACE_ID", :string)
  ]
