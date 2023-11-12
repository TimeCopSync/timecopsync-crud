defmodule TimecopsyncCrud.Projects do
  alias TimecopsyncCrud.Projects.ProjectModel
  alias TimecopsyncCrud.Repo
  import Ecto.Query

  def get_project(id) do
    Repo.get(Project, id)
  end

  def remove_project!(id) do
    Repo.delete!(get_project(id))
  end

  def get_projects(limit \\ nil, show_archived \\ false) do
    Repo.all(
      from p in ProjectModel,
        order_by: [asc: p.name],
        # Because we show unarchived, always
        where: p.archived == ^show_archived and p.archived == false,
        limit: ^limit
    )
  end

  def create_project!(name, colour, archived \\ false) do
    Repo.insert(%ProjectModel{
      id: Ecto.UUID.generate(),
      name: name,
      colour: colour,
      archived: archived
    })
  end

  def archive_project!(id, archived \\ true) do
    Repo.update!(ProjectModel.changeset(get_project(id), %{archived: archived}))
  end

  def set_project_colour!(id, colour) do
    Repo.update!(ProjectModel.changeset(get_project(id), %{colour: colour}))
  end

  def set_project_name!(id, name) do
    Repo.update!(ProjectModel.changeset(get_project(id), %{name: name}))
  end
end
