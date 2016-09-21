defmodule Martha.Router do
  use Martha.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Martha do
    pipe_through :browser

    resources "/registrations", RegistrationController, only: [:create]

    post   "/login",  SessionController, :create
    delete "/logout", SessionController, :delete

    resources "/", StatusController, only: [:index, :create, :edit, :update, :delete]
  end
end
