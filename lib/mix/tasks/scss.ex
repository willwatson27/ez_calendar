defmodule Mix.Tasks.EzCalendar.Scss do
  alias Mix.Tasks.EzCalendar.StylesheetInstaller
  @moduledoc false
  # Mix task for installing scss stylesheets for EZCalendar.
  
  use Mix.Task
  @shortdoc "Install scss stylesheets for calendars"

  def run(_) do
    StylesheetInstaller.install("scss")
  end
end