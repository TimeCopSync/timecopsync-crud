defmodule TimecopsyncCrud.Projects do
  alias TimecopsyncCrud.Projects.Project
  alias TimecopsyncCrud.Repo

  def get_project(id) do
    Repo.get(Project, id)
  end
end
