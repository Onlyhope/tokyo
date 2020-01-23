import Config


config :tokyo, ecto_repos: [Tokyo.Repo]

config :tokyo, Tokyo.Repo,
  database: "tokyo",
  username: System.fetch_env!("PSQL_USERNAME"),
  password: System.fetch_env!("PSQL_PASSWORD"),
  hostname: "localhost"

config :tokyo, initial_repo_state: %{}

