defmodule TimecopsyncCrudWeb.Router do
  use TimecopsyncCrudWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", TimecopsyncCrudWeb do
    pipe_through :api

    resources "/projects", ProjectController, except: [:new, :edit]
  end

  scope "/api/swagger" do
    forward "/", PhoenixSwagger.Plug.SwaggerUI,
      otp_app: :timecopsync_crud,
      swagger_file: "swagger.json"
  end

  def swagger_info do
    %{
      basePath: "/api",
      openapi: "3.1.0",
      schemes: ["https", "http"],
      info: %{
        title: "TimeCop Sync CRUD API",
        summary: "API that operates CRUD operations on projects and timer entries",
        description: "API that operates CRUD operations on projects and timer entries",
        contact: %{
          name: "Yann POMIE",
          email: "yann.pomie@laposte.net",
          url: "https://yann-pomie.fr"
        },
        license: %{
          name: "MIT",
          url: "https://github.com/TimeCopSync/timecopsync-crud/blob/main/LICENSE"
        },
        version: "1.0"
      }
    }
  end

  # Enable LiveDashboard in development
  if Application.compile_env(:timecopsync_crud, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: TimecopsyncCrudWeb.Telemetry
    end
  end
end
