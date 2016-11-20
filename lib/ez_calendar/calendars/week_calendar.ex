defmodule EZCalendar.WeekCalendar do
  @moduledoc false
  @behaviour EZCalendar.Calendar

  import Calendar.Date, only: [to_erl: 1, day_of_week_zb: 1, add!: 2, subtract!: 2]
  import EZCalendar.ParamParser, only: [to_params: 1]

  alias EZCalendar.WeekCalendar
  defstruct [:title, :dates, :next, :prev, :params]

  def html_module, do:  EZCalendar.HTML.WeekCalendar

  def date_range(date, _opts) do
    week_range(date)
  end

  defp week_range(date) do
    date = date |> to_erl

    start_date = subtract!(date, day_of_week_zb(date))
    end_date = add!(start_date, 6)

    {start_date, end_date} 
  end

  def build(dates, date) do
    {y, m, d} = date |> to_erl


    %WeekCalendar{
      title: date |> title,
      dates: dates,
      next: date |> add!(7) |> to_params,
      prev: date |> subtract!(7) |> to_params,
      params: {y, m, d} |> to_params,
    }
  end

  defp title date do
    {start_date, end_date} = week_range(date)
    start_date = start_date |> Calendar.Strftime.strftime!("%d %b %Y")
    end_date = end_date |> Calendar.Strftime.strftime!("%d %b %Y" ) 
    start_date <> " - " <> end_date   
  end
end
