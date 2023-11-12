defmodule TimecopsyncCrud.Repo.Migrations.AddProjects do
  use Ecto.Migration

  def change do
    create table(:project, primary_key: false) do
      add :id, :uuid, primary_key: true, null: false
      add :name, :string, null: false
      add :colour, :integer, null: true
      add :archived, :boolean, null: false, default: false

      timestamps()
    end
  end
end
