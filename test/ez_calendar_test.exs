defmodule EZCalendarTest do
  use ExUnit.Case
  alias EZCalendar.Repo
  alias EZCalendar.Event
  doctest EZCalendar

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(EZCalendar.Repo)
  end

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

end
