defmodule EZCalendar.DayCalendarTest do
  use ExUnit.Case, async: true
  alias EZCalendar.Repo
  alias EZCalendar.Event
  alias EZCalendar.DayCalendar

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(EZCalendar.Repo)
  end
 
  test "returns the correct date range" do
    {start_date, end_date} = DayCalendar.date_range({2016, 11, 1})

    assert start_date == ~D[2016-11-01]
    assert end_date == ~D[2016-11-01]
  end

  test "returns a struct with the correct params" do
    params = Event |> Repo.day_calendar!({2016, 11, 1}) |> Map.get(:params)
    assert params.day == 1
    assert params.month == 11
    assert params.year == 2016
  end

  test "returns a struct with the correct next" do
    next = Event |> Repo.day_calendar!({2016, 12, 31}) |> Map.get(:next)
    assert next.day == 1
    assert next.month == 1
    assert next.year == 2017
  end

  test "returns a struct with the correct prev" do
    prev = Event |> Repo.day_calendar!({2016, 1, 1}) |> Map.get(:prev)
    assert prev.day == 31
    assert prev.month == 12
    assert prev.year == 2015
  end

  test "returns a struct with the correct title" do
    title = Event |> Repo.day_calendar!({2016, 11, 1}) |> Map.get(:title)
    assert title == "November 1, 2016"
  end

  test "returns a struct with the correct dates" do
    dates = Event |> Repo.day_calendar!({2016, 11, 1}) |> Map.get(:dates)
    
    start_date = dates |> List.first
    end_date = dates |> List.last

    assert start_date.day == 1
    assert start_date.month == 11
    assert start_date.year == 2016

    assert end_date.day == 1
    assert end_date.month == 11
    assert end_date.year == 2016
  end
end