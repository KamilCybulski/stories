defmodule Stories.Plugs.SetUser do
  import Plug.Conn, only: [get_session: 2, assign: 3]

  def init (_) do end

  def call(conn, _) do
    user_id = get_session(conn, :user_id)
    process(conn, user_id)
  end

  defp process(conn, nil) do
    assign(conn, :current_user, nil)
  end

  defp process(conn, user_id) do
    user = Stories.Accounts.get_user!(user_id)
    assign(conn, :current_user, user)
  end
end