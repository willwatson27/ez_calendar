defmodule EZCalendar.Mixfile do
  use Mix.Project

  def project do
    [
      app: :ez_calendar,
      version: "0.1.5",
      elixir: "~> 1.3",
      elixirc_paths: path(Mix.env),
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps(),

      # Coverails
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: ["coveralls": :test, "coveralls.detail": :test, "coveralls.post": :test, "coveralls.html": :test],
     
      # ExDoc
      name: "EZCalendar",
      source_url: "https://github.com/willwatson27/ez_calendar",
      homepage_url: "https://github.com/willwatson27/ez_calendar",
      docs: [
        main: "readme", # The main page in the docs
        # logo: "path/to/logo.png",
        extras: ["README.md"]
      ],
      
      # HEX
      package: package,
      description: "Build calendars from ecto queries, includes view helpers for easy rendering with Phoenix",
    ]
  end

  def package do
    [
      maintainers: ["Will Watson"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/willwatson27/ez_calendar"}
    ]
  end


  def application do
    [applications: application(Mix.env)]
  end
  defp application(:test), do: [:postgrex, :logger, :calendar, :ecto]
  defp application(_), do: [:logger, :calendar, :ecto]


  defp path(:test) do
    ["lib", "test/support", "test/fixtures"]
  end
  defp path(_), do: ["lib"]  

  defp deps do
    [
      {:phoenix_html, "~> 2.7"},
      {:ecto, "~> 2.0"},
      {:calendar, "~> 0.16.1"},

      {:ex_doc, ">= 0.0.0", only: :dev},
      
      {:calecto, "~> 0.16.0", only: :test},
      {:timex, "~> 3.0", only: :test},
      {:timex_ecto, "~> 3.0", only: :test},
      {:postgrex, "~> 0.12.0", only: :test},
      {:excoveralls, "~> 0.5", only: :test},
    ]
  end
end
