defmodule EZCalendar.HTML.Week do
  use Phoenix.HTML
  import EZCalendar.HTML, only: [build_days: 3, build_weekdays: 0]

  def build conn, calendar, func do
    [
      content_tag(:div, calendar.title, class: "title"),
      content_tag(:table, 
        [
          content_tag(:tr, build_weekdays), 
          build_days(calendar.dates, func, __MODULE__)
        ], class: "calendar"
      )
    ]
  end

  def day_class date do
    class = ["day"]
    class = if date.today?, do: ["today" | class], else: class 
    class |> Enum.join(" ")
  end
end