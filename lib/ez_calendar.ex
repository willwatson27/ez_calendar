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
      def calendar!(query, calendar_type, date, opts \\ []) do
        EZCalendar.build!(calendar_type, __MODULE__, query, date, opts)
      end

      def month_calendar(query, date, opts \\ []) do
        EZCalendar.build(EZCalendar.MonthCalendar, __MODULE__, query, date, opts)
      end
      def month_calendar!(query, date, opts \\ []) do
        EZCalendar.build!(EZCalendar.MonthCalendar, __MODULE__, query, date, opts)
      end

      def week_calendar(query, date, opts \\ []) do
        EZCalendar.build(EZCalendar.WeekCalendar, __MODULE__, query, date, opts)
      end
      def week_calendar!(query, date, opts \\ []) do
        EZCalendar.build!(EZCalendar.WeekCalendar, __MODULE__, query, date, opts)
      end

      def day_calendar(query, date, opts \\ []) do
        EZCalendar.build(EZCalendar.DayCalendar, __MODULE__, query, date, opts)
      end
      def day_calendar!(query, date, opts \\ []) do
        EZCalendar.build!(EZCalendar.DayCalendar, __MODULE__, query, date, opts)
      end
      
    end
  end

  def build(calendar, repo, query, date, opts) do
    case ParamParser.to_erl(date) do
      {:ok, date_erl} ->
        {:ok, build_calendar(calendar, repo, query, date_erl, opts)}
      error -> error
    end
  end 

  def build!(calendar, repo, query, date, opts) do
    {:ok, date_erl} = ParamParser.to_erl(date)
    build_calendar(calendar, repo, query, date_erl, opts)
  end 

  defp build_calendar(calendar, repo, query, date, opts) do
    {start_date, end_date} = calendar.date_range(date)
    EZCalendar.CalendarBuilder.build(query, repo, start_date, end_date, opts) 
    |> calendar.build(date)
  end

end

