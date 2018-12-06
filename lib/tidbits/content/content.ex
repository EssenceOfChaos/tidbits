defmodule Tidbits.Content do
  @moduledoc """
  The Content context.
  """

  import Ecto.Query, warn: false
  alias Tidbits.Repo

  alias Tidbits.Content.Post
  alias Tidbits.Accounts.User

  def list_posts(params) do
    search_term = get_in(params, ["query"])
    Post
    |> Post.search(search_term)
    |> Repo.all()
  end

  def get_post!(id), do: Repo.get!(Post, id)

  def get(slug) do
    Repo.get_by(Post, slug: slug)
  end

  def get(slug, true) do
    Repo.get_by(Post, slug: slug)
    |> Repo.preload([:user])
  end

  def create_post(%User{} = user, attrs \\ %{}) do
    %Post{}
    |> Post.changeset(attrs)
    |> put_user(user)
    |> Repo.insert()
  end

  def update_post(%Post{} = post, attrs) do
    post
    |> Post.changeset(attrs)
    |> Repo.update()
  end

  def delete_post(%Post{} = post) do
    Repo.delete(post)
  end

  def change_post(%Post{} = post) do
    Post.changeset(post, %{})
  end

    # Private functions
    defp put_user(changeset, user) do
      Ecto.Changeset.put_assoc(changeset, :user, user)
    end

end
