defmodule EZCalendar.HTML do

  defmacro __using__(_opts \\ []) do
    quote do
      import EZCalendar.HTML
      import EZCalendar.HTML.Navigation
    end
  end

  alias EZCalendar.HTML.{MonthCalendar, WeekCalendar, DayCalendar, BiweeklyCalendar}

  @doc """
  HTML helper to render a calendar struct. Takes a HTML calendar module, a calendar struct and a function as arguments.
  
  The function will be called with each of the calendars dates to render its contents
  """
  def calendar(type, struct, func) do
    type.build(struct, func)
  end
  
  @doc "Calls `calendar/3` with EZCalendar.HTML.MonthCalendar as the first argument"
  def month_calendar(struct, func), do: calendar(MonthCalendar, struct, func)
  
  @doc "Calls `calendar/3` with EZCalendar.HTML.WeekCalendar as the first argument"
  def week_calendar(struct, func), do: calendar(WeekCalendar, struct, func)
  
  @doc "Calls `calendar/3` with EZCalendar.HTML.DayCalendar as the first argument"
  def day_calendar(struct, func), do: calendar(DayCalendar, struct, func)
  
  @doc "Calls `calendar/3` with EZCalendar.HTML.BiweeklyCalendar as the first argument"
  def biweekly_calendar(struct, func), do: calendar(BiweeklyCalendar, struct, func)

end
