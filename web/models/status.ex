defmodule Martha.Status do
  use Martha.Web, :model

  schema "statuses" do
    field :type, :string
    field :description, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:type, :description])
    |> validate_required([:type, :description])
  end

  def latest_statuses do
    Ecto.Query.from(m in Martha.Status, order_by: [desc: m.inserted_at])
  end

  def display_date(status) do
    status.inserted_at
    |> Timex.format!("%B %d, %Y at %l:%M %P", :strftime)
  end

  def reflection?(status), do: status.type == "reflection"
end
