defmodule TimecopsyncCrudWeb.TimerJSON do
  alias TimecopsyncCrud.Projects.Timer

  @doc """
  Renders a list of timers.
  """
  def index(%{timers: timers}) do
    %{
      meta: %{total: length(timers)},
      data: for(timer <- timers, do: data(timer))
    }
  end

  @doc """
  Renders a single timer.
  """
  def show(%{timer: timer}) do
    %{data: data(timer)}
  end

  defp data(%Timer{} = timer) do
    %{
      id: timer.id,
      description: timer.description,
      start_time: timer.start_time,
      end_time: timer.end_time,
      notes: timer.notes,
      project_id: timer.project_id
    }
  end
end
