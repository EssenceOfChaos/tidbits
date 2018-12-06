defmodule TidbitsWeb.PostController do
  use TidbitsWeb, :controller

  alias Tidbits.Content
  alias Tidbits.Content.Post


  def index(conn, params) do
    posts = Content.list_posts(params)
    render(conn, "index.html", posts: posts)
  end

  def new(conn, _params) do
    changeset = Content.change_post(%Post{})
    render(conn, "new.html", changeset: changeset)
  end

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

  def show(conn, %{"id" => slug}) do
    with %Post{} = post <- Content.get(slug, true) do
      render(conn, "show.html", post: post)
    end
  end

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

  def delete(conn, %{"id" => id}) do
    post = Content.get_post!(id)
    {:ok, _post} = Content.delete_post(post)

    conn
    |> put_flash(:info, "Post deleted successfully.")
    |> redirect(to: Routes.post_path(conn, :index))
  end
end
