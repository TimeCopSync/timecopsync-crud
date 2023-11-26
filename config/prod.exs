import Config

# Do not print debug messages in production
config :logger, level: :info

# Runtime production configuration, including reading
# of environment variables, is done on config/runtime.exs.

config :timecopsync_crud, TimecopsyncCrud.Web.Endpoint,
  # Expects url host and port to be configured in Endpoint.init callback
  load_from_system_env: true,
  url: [host: "example.com", port: 80]
