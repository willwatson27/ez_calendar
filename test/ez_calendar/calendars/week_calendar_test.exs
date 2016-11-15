defmodule EZCalendar.WeekCalendarTest do
  use ExUnit.Case, async: true
  alias EZCalendar.Repo
  alias EZCalendar.Event
  alias EZCalendar.WeekCalendar

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(EZCalendar.Repo)
  end
 
  test "returns the correct date range" do
    {start_date, end_date} = WeekCalendar.date_range({2016, 11, 1})

    assert start_date == ~D[2016-10-30]
    assert end_date == ~D[2016-11-05]
  end

  test "returns a struct with the correct params" do
    params = Event |> Repo.week_calendar!({2016, 11, 1}) |> Map.get(:params)
    assert params.day == 1
    assert params.month == 11
    assert params.year == 2016
  end

  test "returns a struct with the correct next" do
    next = Event |> Repo.week_calendar!({2016, 12, 31}) |> Map.get(:next)
    assert next.day == 7
    assert next.month == 1
    assert next.year == 2017
  end

  test "returns a struct with the correct prev" do
    prev = Event |> Repo.week_calendar!({2016, 1, 1}) |> Map.get(:prev)
    assert prev.day == 25
    assert prev.month == 12
    assert prev.year == 2015
  end

  test "returns a struct with the correct title" do
    title = Event |> Repo.week_calendar!({2016, 11, 1}) |> Map.get(:title)
    assert title == "30 Oct 2016 - 05 Nov 2016"
  end

  test "returns a struct with the correct dates" do
    dates = Event |> Repo.week_calendar!({2016, 11, 1}) |> Map.get(:dates)
    
    start_date = dates |> List.first
    end_date = dates |> List.last

    assert start_date.day == 30
    assert start_date.month == 10
    assert start_date.year == 2016

    assert end_date.day == 5
    assert end_date.month == 11
    assert end_date.year == 2016
  end
end