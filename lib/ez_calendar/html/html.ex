defmodule EZCalendar.HTML do
  use Phoenix.HTML

  defmacro __using__(_opts \\ []) do
    quote do
      import EZCalendar.HTML
    end
  end

  alias EZCalendar.HTML.{Month, Week, Day}

  def calendar(type,conn, struct, func) do
    type.build(conn, struct, func)
  end

  def month_calendar(conn, struct, func), do: calendar(Month, conn, struct, func)
  def week_calendar(conn, struct, func), do: calendar(Week, conn, struct, func)
  def day_calendar(conn, struct, func), do: calendar(Day, conn, struct, func)


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
