defmodule EZCalendar.HTML.DayCalendar do
  use Phoenix.HTML

    def build calendar, func do
      content_tag(:table, 
        [
          content_tag(:tr,  content_tag(:td, calendar.weekday) , class: "weekday"), 
          build_day(calendar.dates, func)
        ], class: "ez-calendar"
      )
  end

  defp day_class date do
    class = ["day"]
    class = if date.today?, do: ["today" | class], else: class 
    class |> Enum.join(" ")
  end

  defp build_day dates, func do
    date = dates |> List.first 

    content_tag(:td, class: day_class(date)) do
      [
        content_tag(:div, date.day, class: "date"), 
        content_tag(:div, func.(date), class: "data")
      ]
    end
  end
end