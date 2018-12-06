defmodule TidbitsWeb.SessionController do
  use TidbitsWeb, :controller
  alias Tidbits.Accounts

  def new(conn, _) do
    render(conn, "new.html")
  end

  def create(conn, %{"session" => %{"email" => email, "password" => password}}) do
    case Accounts.authenticate_user(email, password) do
      {:ok, user} ->
        conn
        |> put_session(:user_id, user.id)
        |> Accounts.login(user)
        |> put_flash(:info, "You have successfully logged in!")
        |> redirect(to: Routes.page_path(conn, :index))
        # |> redirect_after_login(user)

      {:error, _} ->
        conn
        |> put_flash(:error, "Invalid email or password")
        |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
    |> Accounts.logout()
    |> put_flash(:info, "You've been successfully logged out")
    |> redirect(to: Routes.page_path(conn, :index))
  end

  # Private

  # defp redirect_after_login(conn, user) do
  #   case user.admin do
  #     true -> redirect(conn, to: Routes.admin_home_path(conn, :index))
  #     false -> redirect(conn, to: Routes.page_path(conn, :index))
  #   end
  # end

end
