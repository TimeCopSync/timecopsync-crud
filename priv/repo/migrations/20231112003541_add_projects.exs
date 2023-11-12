defmodule TimecopsyncCrud.Repo.Migrations.AddProjects do
  use Ecto.Migration

  def change do
    create table(:project) do
      add :id, :string, primary_key: true, size: 36, null: false
      add :name, :string, null: false
      add :colour, :integer, null: true
      add :archived, :boolean, null: false, default: false

      timestamps()
    end
  end
end
