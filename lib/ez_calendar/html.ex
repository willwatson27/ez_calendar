defmodule EZCalendar.HTML do

  defmacro __using__(_opts \\ []) do
    quote do
      import EZCalendar.HTML
      import EZCalendar.HTML.Navigation
    end
  end

  alias EZCalendar.HTML.{MonthCalendar, WeekCalendar, DayCalendar}

  @doc """
  HTML helper to render a calendar struct. Takes a HTML calendar module, a calendar struct and a function as arguments.
  
  The function that will be called with each of the calendars dates to render its contents
  """
  def calendar(type, struct, func) do
    type.build(struct, func)
  end
  
  @doc "Calls `calendar/3` with the EZCalendar.HTML.MonthCalendar module"
  def month_calendar(struct, func), do: calendar(MonthCalendar, struct, func)
  
  @doc "Calls `calendar/3` with the EZCalendar.HTML.WeekCalendar module"
  def week_calendar(struct, func), do: calendar(WeekCalendar, struct, func)
  
  @doc "Calls `calendar/3` with the EZCalendar.HTML.DayCalendar module"
  def day_calendar(struct, func), do: calendar(DayCalendar, struct, func)

end
