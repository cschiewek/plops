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
    plug :authorize
  end

  # Anonymouse routes
  scope "/", Plops do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    scope "/auth" do
      get "/:provider", AuthenticationController, :request
      get "/:provider/callback", AuthenticationController, :callback
      post "/:provider/callback", AuthenticationController, :callback
    end
    scope "/responses" do
      get "/:token", RespondantController, :edit, as: :responses
      put "/:token", RespondantController, :update, as: :responses
    end
  end

  # Authenticated routes
  scope "/", Plops do
    pipe_through [:browser, :authentication]

    delete "/auth/logout", AuthenticationController, :logout
    get "notifications", UserController, :show
    get "send", UserController, :send
    get "settings", UserController, :edit
    patch "settings", UserController, :update
    put "settings", UserController, :update
    delete "settings", UserController, :delete
  end
end
