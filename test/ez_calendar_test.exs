defmodule EZCalendarTest do
  use ExUnit.Case
  alias EZCalendar.Repo
  alias EZCalendar.Event
  doctest EZCalendar

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(EZCalendar.Repo)
  end

  ###
  # Repo Functions
  ###

  test "returns a month calendar" do
    calendar = Event |> Repo.month_calendar({2016, 11})
    assert calendar.__struct__ == EZCalendar.MonthCalendar
  end

  test "returns a week calendar" do
    calendar = Event |> Repo.week_calendar({2016, 11, 1})
    assert calendar.__struct__ == EZCalendar.WeekCalendar
  end

  test "returns a day calendar" do
    calendar = Event |> Repo.day_calendar({2016, 11, 1})
    assert calendar.__struct__ == EZCalendar.DayCalendar
  end

  test "returns a calendar for a given module" do
    calendar = Event |> Repo.calendar(EZCalendar.MonthCalendar, {2016, 11})
    assert calendar.__struct__ == EZCalendar.MonthCalendar
  end

  ###
  # Helper Functions
  ###

  test "converts an erl into a map" do
    date = EZCalendar.map_from_date({2016, 11, 1})

    assert date.day == 1
    assert date.month == 11
    assert date.year == 2016
  end

  test "returns the month name from a date" do
    month = EZCalendar.month_name({2016, 11, 1})
    assert month == "November"
  end

end
