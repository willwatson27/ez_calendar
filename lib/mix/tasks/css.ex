defmodule Mix.Tasks.EzCalendar.Css do
  alias Mix.Tasks.EzCalendar.StylesheetInstaller
  @moduledoc """
  Mix task for installing css stylesheets for EZCalendar.
  """
  use Mix.Task
  @shortdoc "Install css stylesheets for calendars"

  def run(_) do
    StylesheetInstaller.install("css")
  end
end