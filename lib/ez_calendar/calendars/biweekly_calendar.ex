defmodule EZCalendar.BiweeklyCalendar do
  @moduledoc false

  import EZCalendar.ParamParser, only: [ to_params: 1, to_erl: 1 ]
  import Calendar.Date, only: [ day_of_week_zb: 1, add!: 2, subtract!: 2, diff: 2 ]

  alias EZCalendar.BiweeklyCalendar
  defstruct [:title, :dates, :next, :prev, :params]

  def html_module, do: EZCalendar.HTML.BiweeklyCalendar

  def date_range date, opts do
    biweekly_start =  get_biweekly_start(opts)

    start_of_week = date |> subtract!((day_of_week_zb(date) - day_of_week_zb(biweekly_start)))

    case diff(start_of_week, biweekly_start) |> rem(14) |> abs do
      0 ->
        # first week
        end_date = add!(start_of_week, 13)
        {start_of_week, end_date}
      7 -> 
        # second week
        start_date = subtract!(start_of_week, 7)
        end_date = add!(start_of_week, 6)
        {start_date, end_date}          
    end
  end

  defp get_biweekly_start opts do
    opts
    |> Keyword.get(:biweekly_start) 
    || Application.get_env(:ez_calendar, :default_biweekly_start)
    || {2016, 1, 3}     
  end

  def build dates, date do
    {:ok, start_date} = dates |> List.first |> to_erl
    {:ok, end_date}   = dates |> List.last  |> to_erl

    %BiweeklyCalendar{
      title: title(start_date, end_date),
      dates: dates |> Enum.chunk(7),
      params: date |> to_params,
      next: start_date |> add!(14) |> to_params,
      prev: start_date |> subtract!(14) |> to_params,
    }
  end

  defp title start_date, end_date do
    start_date = start_date |> Calendar.Strftime.strftime!("%d %b %Y")
    end_date = end_date  |> Calendar.Strftime.strftime!("%d %b %Y" ) 
    start_date <> " - " <> end_date
  end
end
