defmodule TimecopsyncCrud.Projects do
  alias TimecopsyncCrud.Projects.ProjectModel
  alias TimecopsyncCrud.Repo
  import Ecto.Query
  require Logger

  def get_project(id) do
    case Repo.get(ProjectModel, id) do
      p when p != nil -> {:ok, p}
      _ -> {:error, :not_found}
    end
  end

  def get_project!(id) do
    Repo.get!(Project, id)
  end

  def remove_project!(id) do
    Repo.delete!(get_project!(id))
  end

  def remove_project(%ProjectModel{} = project) do
    Repo.delete(project)
  end

  def get_projects(query_opts \\ %{}) do
    Repo.all(
      from p in ProjectModel,
        order_by: [asc: p.name],
        # Because we show unarchived, always
        where: p.archived == false or p.archived == ^Map.get(query_opts, "show_archived", false),
        limit: ^Map.get(query_opts, "limit", 100)
    )
  end

  def create_project(attrs \\ %{}) do
    %ProjectModel{
      id: Ecto.UUID.generate()
    }
    |> ProjectModel.changeset(attrs)
    |> Repo.insert()
  end

  def update_project(%ProjectModel{} = project, attrs) do
    project
    |> ProjectModel.changeset(attrs)
    |> Repo.update()
  end
end
