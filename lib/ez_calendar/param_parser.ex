defmodule EZCalendar.ParamParser do
  @moduledoc false

  @doc """
  Formats the params into an erl representing the date. 
  Returns a tuple containing :ok and the erl or :error and the reason.

  Params can be a Date, DateTime, tuple or map containing a day month and year. 
  Tuple and map values will be cast as integers.

  The day can be ommited from the params, doing so will result in the first of the month being used.
  """
  def to_erl(params) do 
    case build_erl(params) do
      {:ok, erl} ->
        erl
        |> validate_erl
      {:error, reason} ->
        {:error, reason}
    end
  end
  
  defp build_erl(date) when is_map(date) do
    day = get_value(date, :day, 1)
    month = get_value(date, :month)
    year = get_value(date, :year)

    if month && year do
      build_erl({year, month, day})
    else
      {:error, "Invalid params"}
    end
  end 

  defp build_erl({y, m}) do
    erl = {cast_int(y), cast_int(m), 1}
    {:ok, erl}
  end

  defp build_erl({y, m, d}) do
    erl = {cast_int(y), cast_int(m), cast_int(d)}
    {:ok, erl}
  end

  defp build_erl(_) do
    {:error, "Invalid params"}
  end

  defp get_value(date, key, default \\ nil) do
    string = Atom.to_string(key)

    Map.get(date, string) || Map.get(date, key, default) 
    |> cast_int
  end

  defp cast_int(i) when is_integer(i), do: i
  defp cast_int(i) when is_binary(i), do: String.to_integer(i)
  defp cast_int(_), do: nil

  defp validate_erl(erl) do
    case Date.from_erl(erl) do
      {:ok, _} -> {:ok, erl}
      {:error, _} -> {:error, "Invalid params"}
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