defmodule TimecopsyncCrudWeb do
  @moduledoc """
  The entrypoint for defining your web interface, such
  as controllers, components, channels, and so on.

  This can be used in your application as:

      use TimecopsyncCrudWeb, :controller
      use TimecopsyncCrudWeb, :html

  The definitions below will be executed for every controller,
  component, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below. Instead, define additional modules and import
  those modules here.
  """

  def static_paths, do: ~w(assets fonts images favicon.ico robots.txt)

  def router do
    quote do
      use Phoenix.Router, helpers: false

      # Import common connection and controller functions to use in pipelines
      import Plug.Conn
      import Phoenix.Controller
    end
  end

  def channel do
    quote do
      use Phoenix.Channel
    end
  end

  def controller do
    quote do
      use Phoenix.Controller,
        formats: [:html, :json],
        layouts: [html: TimecopsyncCrudWeb.Layouts]

      import Plug.Conn
      import TimecopsyncCrudWeb.Gettext

      unquote(verified_routes())
    end
  end

  def verified_routes do
    quote do
      use Phoenix.VerifiedRoutes,
        endpoint: TimecopsyncCrudWeb.Endpoint,
        router: TimecopsyncCrudWeb.Router,
        statics: TimecopsyncCrudWeb.static_paths()
    end
  end

  def view do
    quote do
      use Phoenix.View,
        root: "lib/timecopsync_crud_web/templates",
        namespace: TimecopsyncCrudWeb

      import Phoenix.Controller, only: [get_flash: 2, view_module: 1]

      import TimecopsyncCrudWeb.Router.Helpers
      import TimecopsyncCrudWeb.ErrorHelpers
      import TimecopsyncCrudWeb.Gettext
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
