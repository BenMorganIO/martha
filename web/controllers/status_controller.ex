defmodule Martha.StatusController do
  use Martha.Web, :controller

  alias Martha.Session
  alias Martha.Status
  alias Martha.User

  import Ecto.Changeset, only: [cast_assoc: 3]

  def index(conn, _params) do
    if Session.logged_in?(conn) do
      changeset = Status.changeset(%Status{})
      render(conn, "index.html", statuses: statuses(conn), changeset: changeset)
    else
      changeset = User.changeset(%User{})
      render(conn, "index.html", changeset: changeset)
    end
  end

  def create(conn, %{"status" => status_params}) do
    status_with_user = %Status{user_id: Session.current_user(conn).id}
    changeset = Status.changeset(status_with_user, status_params)

    case Repo.insert(changeset) do
      {:ok, _status} ->
        redirect(conn, to: status_path(conn, :index))
      {:error, changeset} ->
        render(conn, "index.html", changeset: changeset, statuses: statuses(conn))
    end
  end

  def edit(conn, %{"id" => id}) do
    status = Repo.get!(Status, id)
    changeset = Status.changeset(status)
    render(conn, "edit.html", status: status, changeset: changeset)
  end

  def update(conn, %{"id" => id, "status" => status_params}) do
    status = Repo.get!(Status, id)
    changeset = Status.changeset(status, status_params)

    case Repo.update(changeset) do
      {:ok, _status} ->
        redirect(conn, to: status_path(conn, :index))
      {:error, changeset} ->
        render(conn, "edit.html", status: status, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    status = Repo.get!(Status, id)
    Repo.delete!(status)
    redirect(conn, to: status_path(conn, :index))
  end

  defp statuses(conn) do
    Repo.all(Status.latest_statuses(conn))
  end
end
