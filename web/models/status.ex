defmodule Martha.Status do
  use Martha.Web, :model

  alias Martha.Session

  schema "statuses" do
    field :type, :string
    field :description, :string
    belongs_to :user, Martha.User

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:type, :description, :user_id])
    |> validate_required([:type, :description, :user_id])
  end

  def latest_statuses(conn) do
    user_id = Session.current_user(conn).id
    Ecto.Query.from s in Martha.Status,
                    order_by: [desc: s.inserted_at],
                    where: [user_id: ^user_id]
  end

  def display_date(status) do
    status.inserted_at
    |> Timex.format!("%B %d, %Y at %l:%M %P", :strftime)
  end

  def reflection?(status), do: status.type == "reflection"
end
