defmodule Martha.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :phone_number, :string
      add :crypted_password, :string

      timestamps()
    end

    create unique_index(:users, [:phone_number])
  end
end
