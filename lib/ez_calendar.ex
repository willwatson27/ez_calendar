defmodule EZCalendar do

  @moduledoc """
  Turns Ecto queries into calendar data structures.
  """

  defmacro __using__(_) do
    quote do

      def calendar(query, calendar_type, date, opts \\ []) do
        EZCalendar.build(calendar_type, __MODULE__, query, date, opts)
      end

      def month_calendar(query, date, opts \\ []) do
        EZCalendar.build(EZCalendar.MonthCalendar, __MODULE__, query, date, opts)
      end

      def week_calendar(query, date, opts \\ []) do
        EZCalendar.build(EZCalendar.WeekCalendar, __MODULE__, query, date, opts)
      end

      def day_calendar(query, date, opts \\ []) do
        EZCalendar.build(EZCalendar.DayCalendar, __MODULE__, query, date, opts)
      end
      
    end
  end

  defp normalize_date(date) when is_map(date) do
    day = Map.get(date, "day", 1) |> cast_int
    month = Map.get(date, "month") |> cast_int
    year = Map.get(date, "year") |> cast_int
    {year, month, day}
  end

  defp normalize_date(date) do
    case date do
      {y, m} -> {cast_int(y), cast_int(m), 1}
      {y, m, d} -> {cast_int(y), cast_int(m), cast_int(d)}
      date -> date |> Calendar.Date.to_erl
    end
  end

  def build(calendar, repo, query, date, opts) do
    date = normalize_date(date)

    {start_date, end_date} = calendar.date_range(date)
    EZCalendar.Builder.build(query, repo, start_date, end_date, opts) 
    |> calendar.build(date)
  end 

  def cast_int(i) when is_integer(i), do: i
  def cast_int(i) when is_binary(i), do: String.to_integer(i)

  def map_from_date(date) do
    {y, m, d} = Calendar.Date.to_erl(date)
    %{day: d, month: m, year: y}
  end

  def month_name(date) do
    date 
    |> Calendar.Date.from_erl! 
    |> Calendar.Strftime.strftime!("%B")
  end

end

