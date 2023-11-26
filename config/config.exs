# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :timecopsync_crud,
  ecto_repos: [TimecopsyncCrud.Repo],
  generators: [timestamp_type: :utc_datetime]

# Configures the endpoint
config :timecopsync_crud, TimecopsyncCrudWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Phoenix.Endpoint.Cowboy2Adapter,
  render_errors: [
    formats: [json: TimecopsyncCrudWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: TimecopsyncCrud.PubSub,
  live_view: [signing_salt: "voo9kjXv"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"

config :timecopsync_crud, :phoenix_swagger,
  swagger_files: %{
    "priv/static/swagger.json" => [
      # phoenix routes will be converted to swagger paths
      router: TimecopsyncCrudWeb.Router,
      # (optional) endpoint config used to set host, port and https schemes.
      endpoint: TimecopsyncCrudWeb.Endpoint
    ]
  }

config :phoenix_swagger, json_library: Jason
