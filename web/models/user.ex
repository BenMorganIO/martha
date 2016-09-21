defmodule Martha.User do
  use Martha.Web, :model

  schema "users" do
    field :name, :string
    field :phone_number, :string
    field :crypted_password, :string
    field :password, :string, virtual: true

    has_many :statuses, Martha.Status

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :phone_number, :password])
    |> validate_required([:name, :phone_number, :password])
    |> unique_constraint(:phone_number)
    |> validate_length(:password, min: 8)
  end
end
