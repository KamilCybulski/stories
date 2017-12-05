defmodule Stories.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  import Stories.Accounts.Auth, only: [put_pass_hash: 1]
  alias Stories.Accounts.User


  schema "users" do
    field :description, :string
    field :img, :string
    field :name, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :description, :img])
    |> validate_required([:name, :description, :img])
    |> validate_length(:description, min: 10, max: 250)
  end

  def registration_changeset(user, attrs) do
    user
    |> changeset(attrs)
    |> cast(attrs, [:password])
    |> validate_length(:password, min: 6, max: 30)
    |> put_pass_hash()
  end
end
