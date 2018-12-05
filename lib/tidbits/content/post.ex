defmodule Tidbits.Content.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tidbits.Accounts.User

  @derive {Phoenix.Param, key: :slug}

  schema "posts" do
    field :body, :string
    field :slug, :string, unique: true
    field :image, :string
    field :likes, :integer, default: 0
    field :published, :boolean, default: false
    field :title, :string
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :body, :published, :image, :likes])
    |> validate_required([:title, :body])
    |> validate_length(:title, min: 3)
    |> validate_length(:body, max: 180)
    |> process_slug
  end

  defp process_slug(%Ecto.Changeset{valid?: validity, changes: %{title: title}} = changeset) do
    case validity do
      true -> put_change(changeset, :slug, Slugger.slugify_downcase(title))
      false -> changeset
    end
  end

  defp process_slug(changeset), do: changeset

end
