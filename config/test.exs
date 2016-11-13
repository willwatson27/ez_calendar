use Mix.Config

config :ez_calendar, ecto_repos: [EZCalendar.Repo]

config :ez_calendar, EZCalendar.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "ez_calendar_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# shut up only log errors
config :logger, :console,
  level: :error