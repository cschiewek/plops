defmodule Plops.Router do
  use Plops.Web, :router
  use Plops.Plugs

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :assign_current_user
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :authentication do
    plug :authenticate
  end

  # Anonymouse routes
  scope "/", Plops do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "authentication", AuthenticationController, :index
    get "authentication/callback", AuthenticationController, :callback
    get "authentication/signout", AuthenticationController, :signout
  end

  # Authenticated routes
  scope "/", Plops do
    pipe_through [:browser, :authentication]

    get "notifications", UserController, :show
    get "send", UserController, :send
    get "settings", UserController, :edit
    patch "settings", UserController, :update
    put "settings", UserController, :update
    delete "settings", UserController, :delete
  end
end
