defmodule EZCalendar.DayCalendar do
  @behaviour EZCalendar.Calendar

  import Calendar.Date, only: [to_erl: 1, add!: 2, subtract!: 2]
  import EZCalendar, only: [map_from_date: 1]

  alias EZCalendar.DayCalendar
  defstruct [:title, :date, :next, :prev, :params, :weekday]

  def date_range(date) do
    date = date |> to_erl

    start_date = subtract!(date, 1)
    end_date = add!(date, 1)

    {start_date, end_date} 
  end 

  def build(dates, _date) do
    info = Enum.at(dates, 1)
    date = {info.year, info.month, info.day}
    %DayCalendar{
      date: info,
      title: date |> title,
      weekday: info.weekday,
      next: date |> add!(1) |> map_from_date,
      prev: date |> subtract!(1) |> map_from_date,
      params: date |> map_from_date,
    }
    |> struct(info)
  end

  defp title date do
    {y, _, d} = date
    month = date |> Calendar.Strftime.strftime!("%B")
    "#{month} #{d}, #{y}"
  end


end
