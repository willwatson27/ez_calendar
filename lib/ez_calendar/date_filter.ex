defmodule EZCalendar.DateFilter do
  @moduledoc false

  import Calendar.Date, only: [before?: 2, after?: 2, same_date?: 2]

  def filter date, query do
    case query.field do
      {starting_field, ending_field} -> 
        range_filter(date, query.results, starting_field, ending_field)
      field -> 
        filter(date, query.results, field)
    end
  end

  defp range_filter date, results, starting_field, ending_field do
    Enum.filter(results, fn(result)->

      starting = db_date_erl(result, starting_field)
      ending = db_date_erl(result, ending_field)

      (after?(date, starting) || same_date?(date, starting)) 
      && (before?(date, ending) || same_date?(date, ending))

    end)
  end

  defp filter date, results, field do
    Enum.filter(results, fn(result)->
       db_date_erl(result, field) == date
    end)
  end

  defp db_date_erl(result, field) do
    date = 
    result 
    |> Map.get(field)

    case date.__struct__ do
      Ecto.Date -> Ecto.Date.to_erl(date)
      Ecto.DateTime -> 
        {date, _} = Ecto.DateTime.to_erl(date)
        date
      _ ->
        Calendar.Date.to_erl(date)
    end
  end

end