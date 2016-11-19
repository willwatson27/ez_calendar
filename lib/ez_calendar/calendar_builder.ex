defmodule EZCalendar.CalendarBuilder do
  @moduledoc false
  
  alias EZCalendar.{DateFilter, QueryRunner}

  import Enum, only: [map: 2, to_list: 1, into: 2]

  import Calendar.Date, only: [
    day_of_week_name: 1, to_erl: 1, same_date?: 2, days_after_until: 3 ]

  def build query, repo, start_date, end_date, opts do
    queries = QueryRunner.run(query, repo, start_date, end_date, opts)
    
    erl_date_list(start_date, end_date)
    |> map(fn(date)-> 
      build_date(date, queries, opts)
    end)

  end

  defp erl_date_list start_date, end_date do
    days_after_until(start_date, end_date, true) 
    |> to_list
    |> map(&to_erl/1)
  end

  defp build_date(date, query, opts)do
    data = date_data(date, query)
    {year, month, day} = date
    
    %{
      day: day,
      month: month,
      year: year,
      data: data,
      weekday: day_of_week_name(date),
      today?: today?(date, opts),
    }
  end

  defp date_data(date, queries) when is_list(queries) do
    queries 
    |> map(fn(query)->
      results = DateFilter.filter(date, query)
      {query.key, results}
    end)
    |> into(%{})    
  end

  defp date_data(date, query)do
    DateFilter.filter(date, query)
  end 

  defp today? date, opts do
    opts[:tz] || Application.get_env(:ez_calendar, :default_tz, "GMT")
    |> Calendar.DateTime.now!
    |> to_erl 
    |> same_date?(date)
  end

end