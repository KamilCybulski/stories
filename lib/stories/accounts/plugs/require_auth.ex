defmodule Stories.Plugs.RequireAuth do
  import Plug.Conn, only: [halt: 1]
  import Phoenix.Controller, only: [put_flash: 3, redirect: 2]
  alias StoriesWeb.Router.Helpers

  def init(_) do end

  def call(conn, _) do
    call(conn)
  end

  defp call(%{assigns: %{current_user: nil}} = conn) do
    conn
    |> put_flash(:error, "You must be logged in to access that page")
    |> redirect(to: Helpers.post_path(conn, :index))
    |> halt()
  end

  defp call(%{assigns: %{current_user: _user}} = conn) do
    conn
  end
end