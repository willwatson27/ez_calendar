defmodule EZCalendarTest do
  use ExUnit.Case, async: true
  alias EZCalendar.Repo
  alias EZCalendar.Event
  alias EZCalendar.{MonthCalendar, WeekCalendar, DayCalendar, BiweeklyCalendar}
  doctest EZCalendar

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(EZCalendar.Repo)
  end

  test "returns an error tuple for invalid dates" do
    {response, _} = Event |> Repo.calendar(MonthCalendar, {2016, 99})
    assert response == :error 
  end

  test "returns a month calendar" do
    {:ok, calendar} = Event |> Repo.month_calendar({2016, 11})
    assert calendar.__struct__ == MonthCalendar

    calendar = Event |> Repo.month_calendar!({2016, 11})
    assert calendar.__struct__ == MonthCalendar
  end

  test "returns a week calendar" do
    {:ok, calendar} = Event |> Repo.week_calendar({2016, 11, 1})
    assert calendar.__struct__ == WeekCalendar

    calendar = Event |> Repo.week_calendar!({2016, 11, 1})
    assert calendar.__struct__ == WeekCalendar
  end

  test "returns a day calendar" do
    {:ok, calendar} = Event |> Repo.day_calendar({2016, 11, 1})
    assert calendar.__struct__ == DayCalendar

    calendar = Event |> Repo.day_calendar!({2016, 11, 1})
    assert calendar.__struct__ == DayCalendar
  end

  test "returns a biweekly calendar" do
    {:ok, calendar} = Event |> Repo.biweekly_calendar({2016, 11, 1})
    assert calendar.__struct__ == BiweeklyCalendar

    calendar = Event |> Repo.biweekly_calendar!({2016, 11, 1})
    assert calendar.__struct__ == BiweeklyCalendar
  end

  test "returns a calendar for a given module" do
    {:ok, calendar} = Event |> Repo.calendar(MonthCalendar, {2016, 11})
    assert calendar.__struct__ == MonthCalendar

    calendar = Event |> Repo.calendar!(MonthCalendar, {2016, 11})
    assert calendar.__struct__ == MonthCalendar
  end

end
