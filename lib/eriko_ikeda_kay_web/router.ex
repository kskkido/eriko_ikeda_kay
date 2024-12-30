defmodule ErikoIkedaKayWeb.Router do
  use ErikoIkedaKayWeb, :router

  alias ErikoIkedaKayWeb.Plugs

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Plugs.EnsureProfile
    plug Plugs.EnsureCurrentPath
    plug :put_root_layout, html: {ErikoIkedaKayWeb.Templates.Layouts, :root}
    plug :put_layout, html: {ErikoIkedaKayWeb.Templates.Layouts, :page}
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ErikoIkedaKayWeb do
    pipe_through :browser

    get "/", Controllers.Home, :index
    get "/contact", Controllers.Contact, :index
    post "/contact", Controllers.Contact, :post
    get "/contact/success", Controllers.Contact, :message_received
    get "/works", Controllers.Projects, :index
    get "/works/:slug", Controllers.Projects, :show
    get "/tags", Controllers.Tags, :index
    get "/tags/:name", Controllers.Tags, :show
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:eriko_ikeda_kay, :dev_routes) do
    scope "/dev" do
      pipe_through :browser
    end
  end
end
