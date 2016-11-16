defmodule EZCalendar.HTML.Navigation do
  @moduledoc """
  HTML helpers to render calendar navigation links
  """
  use Phoenix.HTML
  import String, only: [replace: 3]

  @doc """
  HTML helper for rendering a calendars next link. 
  Takes a calendar struct amd a string to format the path from as arguments.
  The placeholders :day :month and :year will be replaced with the corresponding params.

  "/events/:year/:month/:day"

  "/events?year=:year&month=:month"

  Takes a function or string optional third argument to render something other than the default output.
  """
  def calendar_next(calendar, path, content \\ nil) do 
    content = content || Application.get_env(:ez_calendar, :default_next, ">")

    build_path(path, calendar.next)
    |> build_link(content, "calendar-next")
  end

  @doc """
  The same as `calendar_next` aside from using the calendards `prev` params
  """
  def calendar_prev(calendar, path, content \\ nil) do
    content = content || Application.get_env(:ez_calendar, :default_prev, "<")

    build_path(path, calendar.prev)
    |> build_link(content, "calendar-prev")
  end

  defp build_path path, params do
    path
    |> replace(~r{:year}, "#{params.year}")
    |> replace(~r{:month}, "#{params.month}")
    |> replace(~r{:day}, "#{params.day}")   
  end

  defp build_link(path, content, class) when is_function(content) do
    link(content.(), to: path, class: class)
  end 

  defp build_link(path, content, class) do
    link(content, to: path, class: class)
  end 

end