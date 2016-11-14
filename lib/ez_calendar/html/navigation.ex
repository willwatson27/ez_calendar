defmodule EZCalendar.HTML.Navigation do
  use Phoenix.HTML

  import String, only: [replace: 3]

  def calendar_next(calendar, path, content \\ nil) do 
    content = content || Application.get_env(:ez_calendar, :default_next, ">")

    build_path(path, calendar.next)
    |> build_link(content, "calendar-next")
  end

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