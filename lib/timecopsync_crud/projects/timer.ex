defmodule TimecopsyncCrud.Projects.Timer do
  alias TimecopsyncCrud.Projects.ProjectModel
  use Ecto.Schema
  import Ecto.Changeset
  import DateTime
  require Logger

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

  # This will convert both :start_time & :end_time to the current time (utc)
  # if given "now" as a value
  defp convert_now_string(attrs) do
    # to force map formatting as phoenix will send a keyword list
    attrs = Enum.into(attrs, %{})

    case attrs do
      %{"start_time" => "now"} ->
        convert_now_string(
          Map.put(attrs, "start_time", utc_now())
          |> convert_now_string()
        )

      %{"end_time" => "now"} ->
        Map.put(attrs, "end_time", utc_now())
        |> convert_now_string()

      _ ->
        attrs
    end
  end

  defp validate_dates(changeset) do
    validate_change(changeset, :start_time, fn _, start_time ->
      case changeset |> get_change(:end_time, nil) do
        # we check it first because if end_time is nil, `start_time > end_time` returns true
        nil -> []
        end_time when start_time > end_time -> [{:end_time, "Cannot happen before start date"}]
        _ -> []
      end
    end)
  end

  @doc false
  def changeset(timer, attrs) do
    timer
    |> cast(convert_now_string(attrs), [:id, :description, :start_time, :end_time, :notes])
    |> validate_required([:id, :start_time])
    |> validate_dates()
  end
end
