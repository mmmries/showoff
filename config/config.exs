# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :showoff, ShowoffWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "oInvc+LG9tsL99Yf58LDI6RwJ9PqSpS38fJxMCqPjAMnIDDW0DJjra9TdOsA31q/",
  render_errors: [view: ShowoffWeb.ErrorView, accepts: ~w(html json)],
  pubsub_server: Showoff.PubSub,
  live_view: [signing_salt: "growb+Aum3o5waHzehcTZ6MtwxlyL+AN"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
