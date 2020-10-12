# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :ambune,
  ecto_repos: [Ambune.Repo]

# Configures the endpoint
config :ambune, AmbuneWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "1scHUauPFWMDjONzZX3ceUgukqQJjLiovDk+gWGf3JkOR0MzKJ2NxISG08v5kdT+",
  render_errors: [view: AmbuneWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Ambune.PubSub,
  live_view: [signing_salt: "II09dVS5"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
