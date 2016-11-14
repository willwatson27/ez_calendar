defmodule EZCalendar.HTML.CalendarUtil do
  use Phoenix.HTML

  def build_weekdays do
    ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"] 
    |> Enum.map(&content_tag(:td, &1))
  end 

  def build_days dates, func, module do
    Enum.map(dates, fn(date)-> 
      content_tag(:td, 
        [
          content_tag(:div, date.day, class: "date"), 
          content_tag(:div, func.(date), class: "data")
        ], class: module.day_class(date)
      )
    end)
  end
end