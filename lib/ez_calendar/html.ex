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

      <%= month_calendar @calendar, fn(date)-> %>
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

  alias EZCalendar.HTML.{MonthCalendar, WeekCalendar, DayCalendar, BiweeklyCalendar}

  @doc """
  Renders a calendar struct for a given module. 

  Takes a HTML calendar module, a calendar struct and a function as arguments.
  The provided function will be called with each calendar date to render its contents

      <%= calendar EZCalendar.MonthCalendar, @calendar, fn(date)-> %>
        <!-- calendar date -->
        <%= for shift <- date.data do %>
          <!-- query results for date -->
        <% end %>
      <% end %>
  """
  def calendar(html_module, calendar_struct, render_func) do
    html_module.build(calendar_struct, render_func)
  end
  
  @doc "Calls `calendar/3` with `EZCalendar.HTML.MonthCalendar` as the first argument"
  def month_calendar(calendar_struct, render_func), 
    do: calendar(MonthCalendar, calendar_struct, render_func)
  
  @doc "Calls `calendar/3` with `EZCalendar.HTML.WeekCalendar` as the first argument"
  def week_calendar(calendar_struct, render_func), 
    do: calendar(WeekCalendar, calendar_struct, render_func)
  
  @doc "Calls `calendar/3` with `EZCalendar.HTML.DayCalendar` as the first argument"
  def day_calendar(calendar_struct, render_func), 
    do: calendar(DayCalendar, calendar_struct, render_func)
  
  @doc "Calls `calendar/3` with `EZCalendar.HTML.BiweeklyCalendar` as the first argument"
  def biweekly_calendar(calendar_struct, render_func), 
    do: calendar(BiweeklyCalendar, calendar_struct, render_func)

end
