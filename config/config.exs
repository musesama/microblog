# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :microblog,
  ecto_repos: [Microblog.Repo]

# Configures the endpoint
config :microblog, MicroblogWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "hTDT4i8ak7XpxSnm1l7Ds7/DxJrzp5jQ/GN6LXdy/Ke8HVI2KNrW8gzYoYimkH/X",
  render_errors: [view: MicroblogWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Microblog.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
