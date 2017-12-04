defmodule Stories.Accounts.Auth do
  import Ecto.Changeset, only: [put_change: 3]
  import Comeonin.Pbkdf2, only: [hashpwsalt: 2]
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
end