defmodule EZCalendar.DayCalendar do
  @moduledoc false
  @behaviour EZCalendar.Calendar

  import Calendar.Date, only: [add!: 2, subtract!: 2]
  import EZCalendar.ParamParser, only: [to_params: 1]

  alias EZCalendar.DayCalendar
  defstruct [:title, :dates, :next, :prev, :params, :weekday]

  def date_range date, _opts do
    date = date |> Date.from_erl!
    {date, date} 
  end 

  def build(dates, _date) do
    info = List.first dates
    date = {info.year, info.month, info.day}
    %DayCalendar{
      dates: [info],
      title: date |> title,
      weekday: info.weekday,
      next: date |> add!(1) |> to_params,
      prev: date |> subtract!(1) |> to_params,
      params: date |> to_params,
    }
    |> struct(info)
  end

  defp title date do
    {y, _, d} = date
    month = date |> Calendar.Strftime.strftime!("%B")
    "#{month} #{d}, #{y}"
  end


end
