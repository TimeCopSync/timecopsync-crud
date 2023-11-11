defmodule TimecopsyncCrud.Repo do
  use Ecto.Repo,
    otp_app: :timecopsync_crud,
    adapter: Ecto.Adapters.Postgres
end
