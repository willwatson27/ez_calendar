defmodule EZCalendar.HTML.BiweeklyCalendar do
  @moduledoc false
  @behaviour EZCalendar.HTML.Calendar
  use Phoenix.HTML
  import EZCalendar.HTML.CalendarUtil, only: [build_calendar_row: 2, build_weekdays: 1]

  def build calendar, func do
    content_tag(:table, class: "ez-calendar biweekly-calendar") do
      [
        calendar.dates |> get_weekdays |> build_weekdays, 
        Enum.map(calendar.dates, fn(week)-> 
          build_calendar_row(week, func)
        end)
      ]
    end
  end

  def get_weekdays dates do
     dates
     |> List.first
     |> Enum.map(fn(date)-> date.weekday end)    
  end

end