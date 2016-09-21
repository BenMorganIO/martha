defmodule Martha.StatusController do
  use Martha.Web, :controller

  alias Martha.Status

  def index(conn, _params) do
    changeset = Status.changeset(%Status{})
    render(conn, "index.html", statuses: statuses, changeset: changeset)
  end

  def create(conn, %{"status" => status_params}) do
    changeset = Status.changeset(%Status{}, status_params)

    case Repo.insert(changeset) do
      {:ok, _status} ->
        redirect(conn, to: status_path(conn, :index))
      {:error, changeset} ->
        render(conn, "index.html", changeset: changeset, statuses: statuses)
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

  defp statuses do
    Repo.all(Status.latest_statuses)
  end
end
