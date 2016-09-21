defmodule Martha.RegistrationController do
  use Martha.Web, :controller
  alias Martha.User

  def create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)

    case Martha.Registration.create(changeset, Martha.Repo) do
      {:ok, changeset} ->
        conn
        |> put_flash(:info, "Your account was created")
        |> put_session(:current_user, changeset.id)
        |> redirect(to: "/")
      {:error, changeset} ->
        conn
        |> put_flash(:info, "Unable to create account")
        |> redirect(to: "/")
    end
  end
end
