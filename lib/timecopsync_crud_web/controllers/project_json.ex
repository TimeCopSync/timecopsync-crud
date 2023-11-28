defmodule TimecopsyncCrudWeb.ProjectJSON do
  alias TimecopsyncCrud.Projects.ProjectModel

  @doc """
  Renders a list of projects.
  """
  def index(%{projects: projects}) do
    %{
      # todo pagination
      meta: %{total: length(projects)},
      data: for(project <- projects, do: data(project))
    }
  end

  @doc """
  Renders a single project.
  """
  def show(%{project: project}) do
    %{data: data(project)}
  end

  defp data(%ProjectModel{} = project) do
    %{
      id: project.id,
      name: project.name,
      colour: project.colour,
      archived: project.archived
    }
  end
end
