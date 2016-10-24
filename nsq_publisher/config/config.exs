# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :nsq_publisher, NsqPublisher.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "2J6zP8ccBVKJ5i+D/aQM8V01+Puk3jlER9T1R8IXsbaKj0iZZ2xynFlNkepEJb21",
  render_errors: [view: NsqPublisher.ErrorView, accepts: ~w(json)],
  pubsub: [name: NsqPublisher.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
# config :logger, :console,
#   format: "$time $metadata[$level] $message\n",
#   metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
