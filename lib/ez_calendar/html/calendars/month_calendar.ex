defmodule EZCalendar.HTML.MonthCalendar do
  @moduledoc false
  @behaviour EZCalendar.HTML.Calendar
  use Phoenix.HTML
  import EZCalendar.HTML.CalendarUtil, only: [build_calendar_row: 2, build_weekdays: 0]

  def build calendar, func do
    content_tag(:table, class: "ez-calendar month-calendar") do
      [
        build_weekdays, 
        Enum.map(calendar.dates, fn(week)-> 
          build_calendar_row(week, func)
        end)
      ]
    end
  end

end