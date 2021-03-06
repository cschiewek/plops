# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :plops, Plops.Endpoint,
  url: [host: "localhost",port: "4000"],
  root: Path.dirname(__DIR__),
  secret_key_base: "ZDYbdIBYeIg06BI5mw7GYhxr8AVfvoTJEj58lxbil+0RyH80ZtHjxtoiU5QrVn5F",
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: Plops.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configure the schedule!
config :quantum, cron: [
    # Every minute
    "* * * * *": { Slack, :send_to_enabled }
]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configure ueberauth providers
config :ueberauth, Ueberauth,
  providers: [github: {Ueberauth.Strategy.Github, [default_scope: "repo"]}]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
