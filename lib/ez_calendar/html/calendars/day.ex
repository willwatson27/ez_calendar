defmodule EZCalendar.HTML.DayCalendar do
  use Phoenix.HTML

    def build calendar, func do
    [
      content_tag(:table, 
        [
          content_tag(:tr,  content_tag(:td, calendar.weekday) , class: "weekday"), 
          build_day(calendar.date, func)
        ], class: "ez-calendar"
      )
    ]
  end

  def day_class date do
    class = ["day"]
    class = if date.today?, do: ["today" | class], else: class 
    class |> Enum.join(" ")
  end

  def build_day date, func do
      content_tag(:td, 
        [
          content_tag(:div, date.day, class: "date"), 
          content_tag(:div, func.(date), class: "data")
        ], class: day_class(date)
      )
  end
end