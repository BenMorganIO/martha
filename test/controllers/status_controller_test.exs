defmodule Martha.StatusControllerTest do
  use Martha.ConnCase

  alias Martha.Status
  @valid_attrs %{}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, status_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing statuses"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, status_path(conn, :new)
    assert html_response(conn, 200) =~ "New status"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, status_path(conn, :create), status: @valid_attrs
    assert redirected_to(conn) == status_path(conn, :index)
    assert Repo.get_by(Status, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, status_path(conn, :create), status: @invalid_attrs
    assert html_response(conn, 200) =~ "New status"
  end

  test "shows chosen resource", %{conn: conn} do
    status = Repo.insert! %Status{}
    conn = get conn, status_path(conn, :show, status)
    assert html_response(conn, 200) =~ "Show status"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, status_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    status = Repo.insert! %Status{}
    conn = get conn, status_path(conn, :edit, status)
    assert html_response(conn, 200) =~ "Edit status"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    status = Repo.insert! %Status{}
    conn = put conn, status_path(conn, :update, status), status: @valid_attrs
    assert redirected_to(conn) == status_path(conn, :show, status)
    assert Repo.get_by(Status, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    status = Repo.insert! %Status{}
    conn = put conn, status_path(conn, :update, status), status: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit status"
  end

  test "deletes chosen resource", %{conn: conn} do
    status = Repo.insert! %Status{}
    conn = delete conn, status_path(conn, :delete, status)
    assert redirected_to(conn) == status_path(conn, :index)
    refute Repo.get(Status, status.id)
  end
end
