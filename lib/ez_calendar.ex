defmodule EZCalendar do

  @moduledoc """
  Turns Ecto queries into calendar data structures.
  """

  alias EZCalendar.ParamParser

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

  def build(calendar, repo, query, date, opts) do
    date = ParamParser.to_erl(date)

    {start_date, end_date} = calendar.date_range(date)
    EZCalendar.CalendarBuilder.build(query, repo, start_date, end_date, opts) 
    |> calendar.build(date)
  end 

  def month_name(date) do
    date 
    |> Calendar.Date.from_erl! 
    |> Calendar.Strftime.strftime!("%B")
  end

  def map_from_date(date) do
    {y, m, d} = Calendar.Date.to_erl(date)
    %{year: y, month: m, day: d}
  end


end

