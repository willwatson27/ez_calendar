defmodule EZCalendar.DayCalendar do
  @behaviour EZCalendar.Calendar

  import Calendar.Date, only: [to_erl: 1, add!: 2, subtract!: 2]
  import EZCalendar, only: [map_from_date: 1]

  alias EZCalendar.DayCalendar
  defstruct [:date, :data, :day, :month, :month_name, :year, :today?, :weekday, :next, :prev, :params]

  def date_range(date) do
    date = date |> to_erl

    start_date = subtract!(date, 1)
    end_date = add!(date, 1)

    {start_date, end_date} 
  end 

  def build(dates, _date) do
    info = Enum.at(dates, 1)
    %DayCalendar{
      month_name: info.date |> Calendar.Strftime.strftime!("%B"),
      next: info.date |> add!(1) |> map_from_date,
      prev: info.date |> subtract!(1) |> map_from_date,
      params: %{day: info.day, month: info.month, year: info.year},
    }
    |> struct(info)
  end


end
