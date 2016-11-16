defmodule EZCalendar.HTML.WeekCalendar do
  @moduledoc false
  @behaviour EZCalendar.HTML.Calendar
  use Phoenix.HTML
  import EZCalendar.HTML.CalendarUtil, only: [build_calendar_row: 2, build_weekdays: 0]

  def build calendar, func do
    content_tag(:table, class: "ez-calendar week-calendar") do
      [
        build_weekdays, 
        build_calendar_row(calendar.dates, func)
      ]
    end
  end

end