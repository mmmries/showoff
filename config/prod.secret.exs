use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
config :showoff, Showoff.Endpoint,
  secret_key_base: "86BDqefTxW0Azc82mtHgitIaRyjxhsTSKQwinlSevgCdE3Fx4XHJoiM0HqmB7m6h"

# Configure your database
config :showoff, Showoff.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "showoff_prod"
