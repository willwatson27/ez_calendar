defmodule EZCalendar.Mixfile do
  use Mix.Project

  def project do
    [app: :ez_calendar,
     version: "0.1.0",
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

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :calendar, :ecto]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [{:phoenix_html, "~> 2.7"},
     {:plug, "~> 1.0"},
     {:ecto, "~> 2.0"},
     {:calendar, "~> 0.16.1"}]
  end
end
