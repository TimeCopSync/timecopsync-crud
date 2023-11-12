defmodule TimecopsyncCrud.Projects.ProjectModel do
  use Ecto.Schema
  import Ecto.Changeset

  schema "projects" do
    # field :id, :string, primary_key: true
    field :name, :string
    field :colour, :integer, default: nil
    field :archived, :boolean, default: false

    timestamps()
  end

  def changeset(item, params) do
    item
    |> cast(params, [:id, :name, :colour, :archived])
  end
end
