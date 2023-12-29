defmodule TimecopsyncCrud.ProjectsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TimecopsyncCrud.Projects` context.
  """

  @doc """
  Generate a timer.
  """
  def timer_fixture(attrs \\ %{}) do
    {:ok, timer} =
      attrs
      |> Enum.into(%{

      })
      |> TimecopsyncCrud.Projects.create_timer()

    timer
  end
end
