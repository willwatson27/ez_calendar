defmodule EZCalendar.ParamParser do
  
  @doc """
  Formats the params into an erl representing the date
  """
  def to_erl(params), do: do_erl(params)
  
  defp do_erl(date) when is_map(date) do
    day = get_value(date, :day, 1)
    month = get_value(date, :month)
    year = get_value(date, :year)
    {year, month, day}
  end 

  defp do_erl({y, m}) do
    {cast_int(y), cast_int(m), 1}
  end

  defp do_erl({y, m, d}) do
    {cast_int(y), cast_int(m), cast_int(d)}
  end

  defp do_erl(date) do
    date |> Calendar.Date.to_erl
  end

  defp get_value date, key, default \\ nil do
    string = Atom.to_string(key)
    date |> Map.get(string) || Map.get(date, key, default) |> cast_int
  end

  defp cast_int(i) when is_integer(i), do: i
  defp cast_int(i) when is_binary(i), do: String.to_integer(i)
 
end