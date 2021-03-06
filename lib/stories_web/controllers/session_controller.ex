defmodule StoriesWeb.SessionController do
  use StoriesWeb, :controller

  alias Stories.Accounts.Auth

  def new(conn, _) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => %{"name" => name, "password" => password}}) do
    case Auth.login_by_username_and_password(conn, name, password) do
      {:ok, conn} ->
        conn
        |> redirect(to: post_path(conn, :index))
      {:error, _, conn} ->
        conn
        |> put_flash(:error, "Wrong username or password")
        |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
    |> Auth.logout
    |> redirect(to: post_path(conn, :index))
  end
end