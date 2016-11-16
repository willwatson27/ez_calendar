defmodule EZCalendar.MonthCalendar do
  @behaviour EZCalendar.Calendar

  import Calendar.Date, only: [number_of_days_in_month: 1, day_of_week_zb: 1, add!: 2, subtract!: 2]
  import EZCalendar.ParamParser, only: [to_params: 1]

  alias EZCalendar.MonthCalendar
  defstruct [:title, :dates, :next, :prev, :params]

  def date_range date do
    date = month_first(date)
    weeks = (number_of_days_in_month(date) + day_of_week_zb(date)) / 7 |> Float.ceil |> round
    start_date = subtract!(date, day_of_week_zb(date))
    end_date = add!(start_date, (weeks * 7 - 1))   
    {start_date, end_date}   
  end

  def build dates, date do
    {year, month, day} = month_first(date)

    %MonthCalendar{
      title: date |> title,
      dates: dates |> parse_dates(month),
      next: date |> next |> to_params, 
      prev: date |> prev |> to_params, 
      params: {year, month, day} |> to_params,
    } 
  end

  defp title date do
    date 
    |> Calendar.Date.from_erl! 
    |> Calendar.Strftime.strftime!("%B %Y")
  end

  defp parse_dates dates, month do
    dates 
    |> add_trailing_flags(month) 
    |> Enum.chunk(7)
  end

  defp next {year, month, _} do
    case month do
      12 -> {year + 1, 1, 1}
      _ -> {year, month + 1, 1}
    end
  end

  defp prev {year, month, _} do
    case month do
      1 -> {year - 1, 12, 1}
      _ -> {year, month - 1, 1}
    end
  end

  defp add_trailing_flags dates, month do
    dates |> Enum.map(fn(date)-> 
      case date.month do
        ^month  -> date |> Map.put(:trailing?, false)
        _       -> date |> Map.put(:trailing?, true)
      end
    end)
  end

  defp month_first({y, m, _}), do: {y, m, 1}
end
