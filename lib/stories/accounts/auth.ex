defmodule Stories.Accounts.Auth do
  import Ecto.Changeset, only: [put_change: 3]
  import Comeonin.Pbkdf2, only: [hashpwsalt: 2]

  def put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :password_hash, hashpwsalt(password, []))
    end
  end
end