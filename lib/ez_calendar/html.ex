defmodule EZCalendar.HTML do

  @moduledoc """
  Functions for rendering the calendars with HTML.

  For easy access to the HTML render functions
  add `EZCalendar` to your view.

      defmodule MyApp.ShiftView do
        use MyApp.Web, :view
        import EZCalendar.HTML
      end

  This will import the functions in `EZCalendar.HTML` and `EZCalendar.HTML.Navigation`

  View example: 

      <%= calendar_prev @calendar, "/shifts/:year/:month" %>
      <%= @calendar.title %>
      <%= calendar_next @calendar, "/shifts/:year/:month" %>

      <%= render_calendar @calendar, fn(date)-> %>
        <!-- calendar date -->
        <%= for shift <- date.data do %>
          <!-- query results for date -->
        <% end %> 
      <% end %> 
  """

  defmacro __using__(_opts \\ []) do
    quote do
      import EZCalendar.HTML
      import EZCalendar.HTML.Navigation
    end
  end


  @doc """
  Renders a calendar struct for a given module. 

  Useful for using an HTML module that isn't the calendars default.

  Takes a HTML calendar module, a calendar struct and a function as arguments.
  The provided function will be called with each calendar date to render its contents.

      <%= render_calendar MyApp.CustomMonthCalendar, @calendar, fn(date)-> %>
        <!-- calendar date -->
        <%= for shift <- date.data do %>
          <!-- query results for date -->
        <% end %>
      <% end %>
  """
  def render_calendar(html_module, calendar_struct, render_func) do
    html_module.build(calendar_struct, render_func)
  end


  @doc """
  Renders a calendar, the HTML module used will be inferred from the calendar type.

  Takes a calendar struct and a function as arguments. 
  The provided function will be called with each calendar date to render its contents.

      <%= render_calendar @calendar, fn(date)-> %>
        <!-- calendar date -->
        <%= for shift <- date.data do %>
          <!-- query results for date -->
        <% end %>
      <% end %>
  """
  def render_calendar(calendar_struct, render_func) do
    calendar_struct 
    |> get_html_module
    |> render_calendar(calendar_struct, render_func)
  end

  defp get_html_module calendar_struct do
    calendar_struct 
    |> Map.get(:__struct__) 
    |> apply(:html_module, [])    
  end

end
