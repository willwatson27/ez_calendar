defmodule EZCalendar.ParamParser do
  
  @doc """
  Formats the params into an erl representing the date
  """
  def to_erl(params) do 
    build_erl(params)
    |> validate_erl
  end
  
  defp build_erl(date) when is_map(date) do
    day = get_value(date, :day, 1)
    month = get_value(date, :month)
    year = get_value(date, :year)
    build_erl({year, month, day})
  end 

  defp build_erl({y, m}) do
    {cast_int(y), cast_int(m), 1}
  end

  defp build_erl({y, m, d}) do
    {cast_int(y), cast_int(m), cast_int(d)}
  end

  defp get_value(date, key, default \\ nil) do
    string = Atom.to_string(key)

    Map.get(date, string) || Map.get(date, key, default) 
    |> cast_int
  end

  defp cast_int(i) when is_integer(i), do: i
  defp cast_int(i) when is_binary(i), do: String.to_integer(i)

  defp validate_erl(erl) do
    case Date.from_erl(erl) do
      {:ok, _} -> {:ok, erl}
      {:error, _} -> {:error, "Invalid date."}
    end
  end

  @doc """
  Formats an erl into map representing the date
  """
  def to_params(date) do
    {y, m, d} = Calendar.Date.to_erl(date)
    %{year: y, month: m, day: d}
  end
 
end