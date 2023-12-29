defmodule TimecopsyncCrud.Repo.Migrations.CreateTimer do
  use Ecto.Migration

  def change do
    create table(:timer, primary_key: false) do
      add :id, :uuid, primary_key: true, null: false
      add :description, :string
      add :start_time, :naive_datetime, null: false
      add :end_time, :naive_datetime
      add :notes, :string
      add :project_id, references(:project, on_delete: :nothing, type: :uuid)

      timestamps(type: :utc_datetime)
    end

    create index(:timer, [:project_id])
  end
end
