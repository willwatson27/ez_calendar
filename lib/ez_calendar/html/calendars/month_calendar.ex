defmodule EZCalendar.HTML.MonthCalendar do
  use Phoenix.HTML
  import EZCalendar.HTML.CalendarUtil, only: [build_days: 3, build_weekdays: 0]

  def build calendar, func do
    content_tag(:table, class: "ez-calendar") do
      [
        content_tag(:tr, build_weekdays), 
        build_weeks(calendar.dates, func)
      ]
    end
  end

  defp build_weeks weeks, func do
    weeks |> Enum.map(&content_tag(:tr, build_days(&1, func, __MODULE__)))
  end

  def day_class date do
    weekday = date.weekday |> String.downcase

    class = ["day #{weekday}"]
    class = if date.trailing?, do: ["trailing" | class], else: class 
    class = if date.today?, do: ["today" | class], else: class 
    class |> Enum.join(" ")
  end

end