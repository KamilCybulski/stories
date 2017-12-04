defmodule Stories.Accounts.Auth do
  import Ecto.Changeset, only: [put_change: 3]
  import Comeonin.Pbkdf2, only: [hashpwsalt: 2, checkpw: 2, dummy_checkpw: 1]
  import Plug.Conn, only: [assign: 3, put_session: 3, configure_session: 2]


  def put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :password_hash, hashpwsalt(password, []))
    end
  end

  def login(conn, user) do
    conn
    |> assign(:current_user, user)
    |> put_session(:user_id, user.id)
    |> configure_session(renew: true)
  end

  def login_by_username_and_password(conn, username, password) do
    user = Stories.Accounts.get_user_by_username(username)

    cond do
      user && checkpw(password, user.password_hash) ->
        {:ok, login(conn, user)}
      user ->
        {:error, :unauthorized, conn}
      true ->
        dummy_checkpw([])
        {:error, :not_found, conn}
    end
  end

  def logout(conn) do
    configure_session(conn, drop: true)
  end
end