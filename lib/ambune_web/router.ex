defmodule AmbuneWeb.Router do
  use AmbuneWeb, :router

  import AmbuneWeb.Plug.UserIdentifier, only: [create_user_identifier: 2]

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {AmbuneWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :create_user_identifier
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", AmbuneWeb do
    pipe_through :browser

    live "/", UserLive.Index, :index

    # Users
    live "/users", UserLive.Index, :index
    live "/users/new", UserLive.Index, :new
    live "/users/:id/edit", UserLive.Index, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", AmbuneWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: AmbuneWeb.Telemetry
    end
  end
end
