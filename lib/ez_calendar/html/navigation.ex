defmodule EZCalendar.HTML.Navigation do
  @moduledoc """
  Functions to render calendar navigation links.

  For easy access to all the render functions
  add `EZCalendar.HTML` to your view.

      defmodule MyApp.ShiftView do
        use MyApp.Web, :view
        import EZCalendar.HTML
      end
      
  If you only want the navigation links you can import `EZCalendar.HTML.Navigation` instead.
  """
  use Phoenix.HTML
  import String, only: [replace: 3]

  @doc """
  Renders a HTML link for the next calendar.

  Takes a calendar struct and a string to format the path from as arguments.
  
  Placeholders `:day`, `:month` and `:year` will be replaced with the corresponding params.

      <%= calendar_next @calendar, "/events/:year/:month/:day" %>

      <%= calendar_next @calendar, "/events?year=:year&month=:month" %>
  
  Takes a string or function as an optional third arugment.
      <%= calendar_next @calendar, "/events/:year/:month", "Next" %>

      <%= calendar_next @calendar, "/events/:year/:month", fn()-> %>
        Next
      <% end %>
  """
  def calendar_next(calendar, path, content \\ nil) do 
    content = content || Application.get_env(:ez_calendar, :default_next, ">")

    build_path(path, calendar.next)
    |> build_link(content, "calendar-next")
  end

  @doc """
  Renders a HTML link for the previous calendar.

  Used the same as `calendar_next/3`
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