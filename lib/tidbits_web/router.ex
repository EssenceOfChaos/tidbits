defmodule TidbitsWeb.Router do
  use TidbitsWeb, :router
  alias Tidbits.Plug

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Plug.Authentication
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :authenticated do
    plug Plug.EnsureAuthentication
  end

  scope "/", TidbitsWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/users", UserController
    resources "/posts", PostController, only: [:index]
    resources("/session", SessionController, only: [:create, :new, :delete])
  end

  scope "/", TidbitsWeb do
    pipe_through [:browser, :authenticated]
    resources "/posts", PostController, only: [:new, :create, :edit, :delete, :show, :update]
  end

  # Other scopes may use custom stacks.
  # scope "/api", TidbitsWeb do
  #   pipe_through :api
  # end
end
