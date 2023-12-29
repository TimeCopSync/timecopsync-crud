defmodule TimecopsyncCrudWeb.TimerJSON do
  alias TimecopsyncCrud.Projects.Timer

  @doc """
  Renders a list of timers.
  """
  def index(%{timers: timers}) do
    %{data: for(timer <- timers, do: data(timer))}
  end

  @doc """
  Renders a single timer.
  """
  def show(%{timer: timer}) do
    %{data: data(timer)}
  end

  defp data(%Timer{} = timer) do
    %{
      id: timer.id
    }
  end
end
