defmodule EZCalendar.HTML do

  defmacro __using__(_opts \\ []) do
    quote do
      import EZCalendar.HTML
      import EZCalendar.HTML.Navigation
    end
  end

  alias EZCalendar.HTML.{MonthCalendar, WeekCalendar, DayCalendar}

  def calendar(type, struct, func) do
    type.build(struct, func)
  end
  
  def month_calendar(struct, func), do: calendar(MonthCalendar, struct, func)
  def week_calendar(struct, func), do: calendar(WeekCalendar, struct, func)
  def day_calendar(struct, func), do: calendar(DayCalendar, struct, func)

end
