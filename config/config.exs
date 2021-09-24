use Mix.Config

config :dinner_menu, DinnerMenuWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "4y6LaJy5kVqJnOgPoLUrGVBJjvJY2SIX3Xbt8vCrWxPOT3L8nXqwE7+IqwGMh7Ay",
  render_errors: [view: DinnerMenuWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: DinnerMenu.PubSub,
  live_view: [signing_salt: "p5e3ucA2"]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

config :tesla, adapter: Tesla.Adapter.Hackney

config :dinner_menu, Services.Airtable,
  api_key: "keyxEnaRiDJWvLSU0",
  base_id: "appraYJwSlFScdVg5",
  api_url: "https://api.airtable.com/v0/"

config :dinner_menu, DinnerMenu.Repo, adapter: DinnerMenu.Repo.Http

import_config "#{Mix.env()}.exs"
