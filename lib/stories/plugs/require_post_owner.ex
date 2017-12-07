defmodule Stories.Plugs.RequirePostOwner do
  import Plug.Conn, only: [halt: 1]
  import Phoenix.Controller, only: [put_flash: 3, redirect: 2]
  alias Stories.Topics
  alias StoriesWeb.Router.Helpers

  def init(_) do end

  def call(%{params: %{"id" => post_id}} = conn, _) do
    post = Topics.get_post!(post_id)

    if post && post.user_id == conn.assigns.current_user.id do
      conn
    else
      conn
      |> put_flash(:error, "Unauthorized")
      |> redirect(to: Helpers.post_path(conn, :index))
      |> halt()
    end
  end
end