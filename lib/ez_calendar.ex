defmodule EZCalendar do
  @moduledoc """
  Functions for building the calendar structs. 
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

  @doc """
  Build a calendar given a calendar module, repo, query, params and options.
  Returns the a tuple containing :ok and the calendor or :error and the reason.

  The params provided in the args are parsed into a date erl 
  and passed to the calendar modules date_range function.

  The timezone and schema field used can be set with :tz and :field as options
  """

  def build(calendar, repo, query, date, opts) do
    case ParamParser.to_erl(date) do
      {:ok, date_erl} ->
        {:ok, build_calendar(calendar, repo, query, date_erl, opts)}
      error -> error
    end
  end 

  @doc """
  The same as build but returns a calendar or raises an error
  """
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

