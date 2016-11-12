defmodule Mix.Tasks.EzCalendar.Css do
  @moduledoc """
  Mix task for installing basic stylesheets for EZCalendar.
  """
  use Mix.Task
  @shortdoc "Install basic stylesheets for calendars"

  def run(_) do
    check_assets
    do_assets
  end

  defp check_assets do
    unless File.exists? "web/static/vendor" do
      Mix.raise """
      Can't find asset directory, make sure you are in the root directory of your phoenix application.
      """
    end
  end

  def do_assets do
    IO.puts "#{IO.ANSI.green}copying css file to web/static/vendor/ez_calendar.css"
    IO.puts "#{IO.ANSI.white}Edit this to fit your needs of your application.\nYou can find all of the css selectors generated by the html helpers in this file"

    from = Path.join([get_package_path, "lib/ez_calendar/html/assets", "ez_calendar.css"])
    to = Path.join([File.cwd!, "web/static/vendor", "ez_calendar.css"])

    File.cp_r from, to, fn(_, _) ->
      IO.gets("#{IO.ANSI.red}This will overwrite the existing css file and destroy any canges you have made. Continue? (y/n): ") == "y\n"
    end
  end

  def get_package_path do
    __ENV__.file
    |> Path.dirname
    |> String.split("/lib/mix")
    |> hd
  end

end