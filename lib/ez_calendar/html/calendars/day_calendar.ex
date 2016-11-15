defmodule EZCalendar.HTML.DayCalendar do
  use Phoenix.HTML

  def build calendar, func do
    content_tag(:table, class: "ez-calendar") do
      [
        content_tag(:tr, class: "weekday") do
          content_tag(:td, calendar.weekday)
        end, 
        build_day(calendar.dates, func)
      ]
    end
  end

  defp day_class date do
    class = ["day"]
    class = if date.today?, do: ["today" | class], else: class 
    class |> Enum.join(" ")
  end

  defp build_day dates, func do
    date = dates |> List.first 

    content_tag(:tr) do
      content_tag(:td, class: day_class(date)) do
        [
          content_tag(:div, date.day, class: "date"), 
          content_tag(:div, func.(date), class: "data")
        ]
      end
    end
  end
end