defmodule Tidbits.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tidbits.Content.Post


  schema "users" do
    field :avatar, :string
    field :display_name, :string
    field :email, :string
    field :is_admin, :boolean, default: false
    field :password_hash, :string
    ## Associations ##
    has_many :posts, Post
    ## Virtual Fields ##
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    timestamps()
  end

  @required_fields ~w(display_name password email)a
  @optional_fields ~w(is_admin avatar)a

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> validate_format(:email, ~r/(\w+)@([\w.]+)/)
    |> validate_length(:display_name, min: 3)
    |> validate_length(:password, min: 6)
    |> put_password_hash()
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Argon2.hash_pwd_salt(pass))
      _ ->
        changeset
    end
  end


end
