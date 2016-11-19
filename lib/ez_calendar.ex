defmodule EZCalendar do
  @moduledoc """
  Functions for building calendars. 

  To use the Repo shortcut functions, add `EZCalendar` to your repo.

      defmodule MyApp.Repo do
        use Ecto.Repo, otp_app: :my_app
        use EZCalendar
      end
  
  The following functions and their bang! variants then become available.

      Repo.calendar(query, calendar_module, params, opts \\\\ [])
      Repo.day_calendar(query, params, opts \\\\ [])
      Repo.week_calendar(query, params, opts \\\\ [])
      Repo.month_calendar(query, params, opts \\\\ [])
      Repo.biweekly_calendar(query, params, opts \\\\ [])  

  You can use a keyword list for multiple queries. Each query will use 
  the default field(s) unless provided in the query list or in the options 
  and the results will be accessible by their key in each dates data field.

      [
        shifts: [Shift, [:starting, :ending]],
        events: [Event, :starting_at],
        meetings: Meeting,
        deliveries: Delivery
      ]
      |> Repo.month_calendar({2016, 11}, field: :scheduled_for)

  Params can be a Date, DateTime, erl style tuple or map containing a day month and year. 
  The day can be ommited from the params, doing so will result in the first of the month being used.
  Tuple and map values will be cast as integers for easy integration with phoenix.

  The timezone and query field can be set with `:tz` and `:field` as options. 
  If using a biweekly calendar the `biweekly_start` can also be set.
  """

  alias EZCalendar.ParamParser

  defmacro __using__(_) do
    quote do
      def calendar(query, calendar_type, params, opts \\ []) do
        EZCalendar.build_calendar(calendar_type, __MODULE__, query, params, opts)
      end
      def calendar!(query, calendar_type, params, opts \\ []) do
        EZCalendar.build_calendar!(calendar_type, __MODULE__, query, params, opts)
      end

      def month_calendar(query, params, opts \\ []) do
        EZCalendar.build_calendar(EZCalendar.MonthCalendar, __MODULE__, query, params, opts)
      end
      def month_calendar!(query, params, opts \\ []) do
        EZCalendar.build_calendar!(EZCalendar.MonthCalendar, __MODULE__, query, params, opts)
      end

      def week_calendar(query, params, opts \\ []) do
        EZCalendar.build_calendar(EZCalendar.WeekCalendar, __MODULE__, query, params, opts)
      end
      def week_calendar!(query, params, opts \\ []) do
        EZCalendar.build_calendar!(EZCalendar.WeekCalendar, __MODULE__, query, params, opts)
      end

      def day_calendar(query, params, opts \\ []) do
        EZCalendar.build_calendar(EZCalendar.DayCalendar, __MODULE__, query, params, opts)
      end
      def day_calendar!(query, params, opts \\ []) do
        EZCalendar.build_calendar!(EZCalendar.DayCalendar, __MODULE__, query, params, opts)
      end

      def biweekly_calendar(query, params, opts \\ []) do
        EZCalendar.build_calendar(EZCalendar.BiweeklyCalendar, __MODULE__, query, params, opts)
      end
      def biweekly_calendar!(query, params, opts \\ []) do
        EZCalendar.build_calendar!(EZCalendar.BiweeklyCalendar, __MODULE__, query, params, opts)
      end
    end
  end

  @doc """
  Builds a calendar struct. Returns a tuple containing `:ok` and the calendar or `:error` and the reason.

  Takes a calendar module, repo, query, params and options as its arguments.
  
  The params provided in the args are parsed into a date erl 
  and passed to the calendar modules `date_range` function.

  The timezone and query field can be set with `:tz` and `:field` as options
  """

  def build_calendar(calendar_module, repo, query, params, opts \\ []) do
    case ParamParser.to_erl(params) do
      {:ok, date} ->
        {:ok, do_build_calendar(calendar_module, repo, query, date, opts)}
      error -> error
    end
  end 

  @doc """
  Builds a calendar struct. Returns a calendar or raises an error

  Arguments and options are the same as `build_calendar/5`
  """

  def build_calendar!(calendar_module, repo, query, params, opts \\ []) do
    {:ok, date} = ParamParser.to_erl(params)
    do_build_calendar(calendar_module, repo, query, date, opts)
  end 

  defp do_build_calendar(calendar_module, repo, query, date, opts) do
    {start_date, end_date} = calendar_module.date_range(date, opts)
    EZCalendar.CalendarBuilder.build(query, repo, start_date, end_date, opts) 
    |> calendar_module.build(date)
  end

end