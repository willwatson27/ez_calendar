defmodule EZCalendar.HTML.CalendarUtil do
  @moduledoc """
  Helper functions used in the HTML calendars. 
  
  Can be useful for creating custom calendars
  """
  use Phoenix.HTML
  
  @doc """
  Builds a table row containing day of the week names. 

  Takes a list of strings as an optional argument, defaults to Sunday..Saturday
  """
  @weekdays ~w[Sunday Monday Tuesday Wednesday Thursday Friday Saturday]

  def build_weekdays days \\ @weekdays do
    content_tag(:tr, class: "weekdays") do
      days
      |> Enum.map(&content_tag(:td, &1))
    end
  end 


  @doc """
  Builds a row of calendar dates with the appropriate css classes.

  It accepts a list of dates and a function that will 
  be called with each date to render its contents.
  """
  def build_calendar_row dates, func do
    content_tag(:tr) do
      Enum.map(dates, fn(date)-> 
        content_tag(:td, class: build_day_class(date)) do 
          [
            content_tag(:div, date.day, class: "date"), 
            content_tag(:div, func.(date), class: "data")
          ]
        end
      end)
    end
  end

  defp build_day_class date do
    ["day"]
    |> weekday_class(date)
    |> today_class(date.today?)
    |> trailing_class(date)
    |> Enum.join(" ")
  end

  defp today_class(class_list, false),  do: class_list
  defp today_class(class_list, true),   do: ["today" | class_list]

  defp weekday_class(class_list, date) do
    weekday = date.weekday |> String.downcase
    [weekday | class_list]
  end

  defp trailing_class(class_list, date) do
    case Map.get(date, :trailing?) do
      true -> ["trailing" | class_list]
      _ -> class_list
    end
  end

end