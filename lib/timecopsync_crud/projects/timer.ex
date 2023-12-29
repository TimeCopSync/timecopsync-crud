defmodule TimecopsyncCrud.Projects.Timer do
  alias TimecopsyncCrud.Projects.ProjectModel
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: false}
  @foreign_key_type :binary_id
  schema "timer" do
    field :description, :string
    field :start_time, :naive_datetime
    field :end_time, :naive_datetime
    field :notes, :string

    belongs_to :project, ProjectModel

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(timer, attrs) do
    timer
    |> cast(attrs, [:id, :description, :start_time, :end_time, :notes])
    |> validate_required([:id, :start_time])
  end
end
