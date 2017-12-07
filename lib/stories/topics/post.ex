defmodule Stories.Topics.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias Stories.Topics.Post


  schema "posts" do
    field :category, :string
    field :content, :string
    field :title, :string
    belongs_to :user, Stories.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(%Post{} = post, attrs) do
    post
    |> cast(attrs, [:title, :category, :content])
    |> validate_required([:title, :category, :content])
    |> validate_length(:content, min: 20)
    |> validate_length(:title, min: 6)
    |> validate_inclusion(:category, ["other", "technology", "lifestyle", "politics", "culture", "media", "design"])
  end
end
