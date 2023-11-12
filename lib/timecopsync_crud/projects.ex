defmodule TimecopsyncCrud.Projects do

  alias TimecopsyncCrud.Projects.Project
  alias TimecopsyncCrud.Repo
  import Ecto.Query

  def get_project(id) do
    Repo.get(Project, id)
  end

end
