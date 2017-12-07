defmodule Stories.TopicsTest do
  use Stories.DataCase

  alias Stories.Topics

  describe "posts" do
    alias Stories.Topics.Post

    @valid_attrs %{category: "some category", content: "some content", title: "some title"}
    @update_attrs %{category: "some updated category", content: "some updated content", title: "some updated title"}
    @invalid_attrs %{category: nil, content: nil, title: nil}

    def post_fixture(attrs \\ %{}) do
      {:ok, post} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Topics.create_post()

      post
    end

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert Topics.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Topics.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      assert {:ok, %Post{} = post} = Topics.create_post(@valid_attrs)
      assert post.category == "some category"
      assert post.content == "some content"
      assert post.title == "some title"
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Topics.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      assert {:ok, post} = Topics.update_post(post, @update_attrs)
      assert %Post{} = post
      assert post.category == "some updated category"
      assert post.content == "some updated content"
      assert post.title == "some updated title"
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Topics.update_post(post, @invalid_attrs)
      assert post == Topics.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Topics.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Topics.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Topics.change_post(post)
    end
  end
end
