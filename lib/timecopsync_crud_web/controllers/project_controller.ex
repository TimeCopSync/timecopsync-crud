defmodule TimecopsyncCrudWeb.ProjectController do
  use TimecopsyncCrudWeb, :controller
  import TimecopsyncCrud.Projects
  require Logger

  action_fallback TimecopsyncCrudWeb.FallbackController

  def index(conn, params) do
    Logger.info(params)

    with {_, updated_params} <-
           Map.get_and_update(params, "show_archived", fn v -> {v, v != nil && v > 0} end) do
      conn
      |> render(:index, projects: get_projects(updated_params))
    end
  end

  def create(conn, %{"project" => project}) do
    with {:ok, p} <- create_project(project) do
      conn
      |> put_status(:created)
      |> render(:show, project: p)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, p} <- get_project(id) do
      conn
      |> render(:show, project: p)
    end
  end

  def update(conn, %{"id" => id, "project" => project_params}) do
    with {:ok, p} <- get_project(id), {:ok, updated} <- update_project(p, project_params) do
      conn
      |> put_status(:ok)
      |> render(:show, project: updated)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, p} <- get_project(id), {:ok, _} <- remove_project(p) do
      send_resp(conn, :no_content, "")
    end
  end
end
