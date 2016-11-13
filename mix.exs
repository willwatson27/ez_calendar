defmodule EZCalendar.Mixfile do
  use Mix.Project

  def project do
    [app: :ez_calendar,
     version: "0.1.2",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     package: package,
     description: "A library for building calendars in ecto and phoenix",
     deps: deps()]
  end

  def package do
    [
      maintainers: ["Will Watson"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/willwatson27/ez_calendar"}
    ]
  end

  def application do
    [applications: [:logger, :calendar, :ecto]]
  end

  defp deps do
    [{:ex_doc, ">= 0.0.0", only: :dev},
    
     {:phoenix_html, "~> 2.7"},
     {:ecto, "~> 2.0"},
     {:calendar, "~> 0.16.1"}]
  end
end
