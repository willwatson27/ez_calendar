defmodule EZCalendar.HTML.DayCalendar do
  @moduledoc false
  @behaviour EZCalendar.HTML.Calendar
  use Phoenix.HTML
  import EZCalendar.HTML.CalendarUtil, only: [build_calendar_row: 2, build_weekdays: 1]

  def build calendar, func do
    content_tag(:table, class: "ez-calendar day-calendar") do
      [
        build_weekdays([calendar.weekday]), 
        build_calendar_row(calendar.dates, func)
      ]
    end
  end

end