defmodule Martha.Repo.Migrations.CreateStatus do
  use Ecto.Migration

  def change do
    create table(:statuses) do
      add :type, :string
      add :description, :string

      timestamps()
    end
  end
end
