defmodule EZCalendar.Builder do
  import Ecto.Query
  import Calendar.Date, only: [day_of_week_name: 1]

  def build query, repo, start_date, end_date, opts do
    query_results(query, repo, start_date, end_date, opts)
    |> build_calendar(start_date, end_date, opts)
  end

  defp query_results query, repo, start_date, end_date, opts do
    attr = opts[:field] || Application.get_env(:ez_calendar, :default_field, :date)
    
    from( q in query, where:  field(q, ^attr) > ^start_date and field(q, ^attr) < ^end_date)
    |> repo.all   
  end

  defp build_calendar results, start_date, end_date, opts do
    Calendar.Date.days_after_until(start_date, end_date, true) 
    |> Enum.to_list
    |> Enum.map(&Date.to_erl/1)
    |> Enum.map(&(build_date(&1, results, opts))) 
  end

  defp build_date date, results, opts do
    {year, month, day} = date
    %{
      day: day,
      month: month,
      year: year,
      data: filter_results(date, results),
      weekday: day_of_week_name(date),
      today?: today?(date, opts),
    }
  end

  defp today? date, opts do
    opts[:tz] || Application.get_env(:ez_calendar, :default_tz, "GMT")
    |> Calendar.DateTime.now!
    |> Calendar.Date.to_erl 
    |> Calendar.Date.same_date?(date)
  end

  defp filter_results date, results do
    Enum.filter(results, fn(result)->
      Ecto.Date.to_erl(result.date) == date
    end)    
  end

end