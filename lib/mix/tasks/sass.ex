defmodule Mix.Tasks.EzCalendar.Sass do
  alias Mix.Tasks.EzCalendar.StylesheetInstaller
  @moduledoc false
  # Mix task for installing sass stylesheets for EZCalendar.
  
  use Mix.Task
  @shortdoc "Install sass stylesheets for calendars"

  def run(_) do
    StylesheetInstaller.install("sass")
  end
end