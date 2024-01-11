defmodule TimecopsyncCrud.Projects do
  alias TimecopsyncCrud.Projects.ProjectModel
  alias TimecopsyncCrud.Projects.Timer

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

  @doc """
  Returns the list of timers.

  ## Examples

      iex> list_timers()
      [%Timer{}, ...]

  """
  def list_timers do
    Repo.all(
      from t in Timer,
        order_by: [desc: t.start_time, desc: t.end_time],
        limit: 100
    )
  end

  @doc """
  Gets a single timer.

  Raises if the Timer does not exist.

  ## Examples

      iex> get_timer!(123)
      %Timer{}

  """
  def get_timer!(id), do: Repo.get!(Timer, id)

  @doc """
  Gets a single timer.

  returns {:ok, timer} or {:error, :not_found}

  ## Examples

      iex> get_timer(123)
      {:ok, %Timer{}}

  """
  def get_timer(id) do
    case Repo.get(Timer, id) do
      t when t != nil -> {:ok, t}
      _ -> {:error, :not_found}
    end
  end

  @doc """
  Creates a timer.

  ## Examples

      iex> create_timer(%{field: value})
      {:ok, %Timer{}}

      iex> create_timer(%{field: bad_value})
      {:error, ...}

  """
  def create_timer(attrs \\ %{}) do
    %Timer{
      id: Ecto.UUID.generate()
    }
    |> Timer.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a timer.

  ## Examples

      iex> update_timer(timer, %{field: new_value})
      {:ok, %Timer{}}

      iex> update_timer(timer, %{field: bad_value})
      {:error, ...}

  """
  def update_timer(%Timer{} = timer, attrs) do
    Timer.changeset(timer, attrs) |> Repo.update()
  end

  @doc """
  Deletes a Timer.

  ## Examples

      iex> delete_timer(timer)
      {:ok, %Timer{}}

      iex> delete_timer(timer)
      {:error, ...}

  """
  def delete_timer(%Timer{} = timer) do
    Repo.delete(timer)
  end

  @doc """
  Returns a data structure for tracking timer changes.

  ## Examples

      iex> change_timer(timer)
      %Todo{...}

  """
  def change_timer(%Timer{} = timer, attrs \\ %{}) do
    timer
    |> ProjectModel.changeset(attrs)
    |> Repo.update()
  end
end
