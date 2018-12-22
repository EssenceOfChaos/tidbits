defmodule TidbitsWeb.Router do
  use TidbitsWeb, :router
  alias Tidbits.Plug
import Tidbits.Accounts, only: [load_current_user: 2]


  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Plug.Authentication
    plug(:load_current_user)

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
    post "/posts/:id/upvote", PostController, :upvote
    post "/posts/:id/downvote", PostController, :downvote

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

  # Private
  # defp put_user_token(conn, _) do
  #   if current_user = conn.assigns[:current_user] do
  #     token = Phoenix.Token.sign(conn, "user socket", current_user.id)
  #     assign(conn, :user_token, token)
  #   else
  #     conn
  #   end
  # end



end
