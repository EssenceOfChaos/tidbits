defmodule TidbitsWeb.PostController do
  use TidbitsWeb, :controller

  alias Tidbits.Content
  alias Tidbits.Content.Post

  @spec index(Plug.Conn.t(), any()) :: Plug.Conn.t()
  def index(conn, params) do
    posts = Content.list_posts(params)
    render(conn, "index.html", posts: posts)

  end

  @spec new(Plug.Conn.t(), any()) :: Plug.Conn.t()
  def new(conn, _params) do
    changeset = Content.change_post(%Post{})
    render(conn, "new.html", changeset: changeset)
  end

  @spec create(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def create(conn, %{"post" => post_params}) do
    user = Guardian.Plug.current_resource(conn)
    case Content.create_post(user, post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "\"#{post.title}\" was created successfully.")
        |> redirect(to: Routes.post_path(conn, :show, post))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  @spec show(any(), map()) :: nil | [%{optional(atom()) => any()}] | %{optional(atom()) => any()}
  def show(conn, %{"id" => slug}) do
    with %Post{} = post <- Content.get(slug, true) do
      render(conn, "show.html", post: post)
    end
  end

  @spec edit(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def edit(conn, %{"id" => id}) do
    current_user = Guardian.Plug.current_resource(conn)
    post = Content.get(id, true)
      if post.user.id == current_user.id do
        changeset = Content.change_post(post)
        render(conn, "edit.html", post: post, changeset: changeset)
      else
        conn
        |> put_flash(:error, "Sorry, only authors may edit their posts!")
        |> redirect(to: Routes.post_path(conn, :index))
      end

  end

  @spec update(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Content.get(id)

    case Content.update_post(post, post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post updated successfully.")
        |> redirect(to: Routes.post_path(conn, :show, post))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", post: post, changeset: changeset)
    end
  end

  @spec delete(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def delete(conn, %{"id" => id}) do
    # post = Content.get_post!(id)
    current_user = Guardian.Plug.current_resource(conn)
    post = Content.get(id, true)
    if post.user.id == current_user.id do
    {:ok, _post} = Content.delete_post(post)
    conn
    |> put_flash(:info, "Post deleted successfully.")
    |> redirect(to: Routes.post_path(conn, :index))
    else
      conn
      |> put_flash(:error, "Sorry, only authors may delete their posts!")
      |> redirect(to: Routes.post_path(conn, :index))
    end
  end

  @spec upvote(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def upvote(conn, %{"id" => id}) do
    post = Content.get(id, true)

    case Content.upvote_post(post) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post upvoted")
        |> redirect(to: Routes.post_path(conn, :show, post))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "index.html", post: post, changeset: changeset)
    end
  end

  @spec downvote(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def downvote(conn, %{"id" => id}) do
    post = Content.get(id, true)

    case Content.downvote_post(post) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post downvoted")
        |> redirect(to: Routes.post_path(conn, :show, post))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "index.html", post: post, changeset: changeset)
    end
end

end
