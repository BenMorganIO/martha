defmodule Martha.Session do
  alias Martha.User

  def current_user(conn) do
    id = Plug.Conn.get_session(conn, :current_user)
    if id, do: Martha.Repo.get(User, id)
  end

  def logged_in?(conn), do: !!current_user(conn)

  def login(params, repo) do
    user = repo.get_by(User, phone_number: params["phone_number"])
    case authenticate(user, params["password"]) do
      true -> {:ok, user}
      _    -> :error
    end
  end

  defp authenticate(user, password) do
    case user do
      nil -> false
      _   -> Comeonin.Bcrypt.checkpw(password, user.crypted_password)
    end
  end
end
