defmodule EZCalendar.MonthCalendarTest do
  use ExUnit.Case, async: true
  alias EZCalendar.Repo
  alias EZCalendar.Event
  alias EZCalendar.MonthCalendar

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(EZCalendar.Repo)
  end

  test "returns the correct date range" do
    {start_date, end_date} = MonthCalendar.date_range({2016, 11, 1})

    assert start_date == ~D[2016-10-30]
    assert end_date == ~D[2016-12-03]
  end

  test "returns a struct with the correct params" do
    params = Event |> Repo.month_calendar!({2016, 11}) |> Map.get(:params)
    assert params.day == 1
    assert params.month == 11
    assert params.year == 2016
  end

  test "returns a struct with the correct next" do
    next = Event |> Repo.month_calendar!({2016, 12}) |> Map.get(:next)
    assert next.day == 1
    assert next.month == 1
    assert next.year == 2017
  end

  test "returns a struct with the correct prev" do
    prev = Event |> Repo.month_calendar!({2016, 1}) |> Map.get(:prev)
    assert prev.day == 1
    assert prev.month == 12
    assert prev.year == 2015
  end

  test "returns a struct with the correct title" do
    title = Event |> Repo.month_calendar!({2016, 11}) |> Map.get(:title)
    assert title == "November 2016"
  end

  test "returns a struct with the correct dates" do
    dates = Event |> Repo.month_calendar!({2016, 11}) |> Map.get(:dates) |> List.flatten
    
    start_date = dates |> List.first
    end_date = dates |> List.last

    assert start_date.day == 30
    assert start_date.month == 10
    assert start_date.year == 2016

    assert end_date.day == 3
    assert end_date.month == 12
    assert end_date.year == 2016
  end

  test "can accept its next value as its params" do
    calendar = Repo.month_calendar!(Event, {2016, 1})
    next = Repo.month_calendar!(Event, Map.get(calendar, :next)) |> Map.get(:params)

    assert next.day == 1
    assert next.month == 2
    assert next.year == 2016
  end

  test "can accept its prev value as its params" do
    calendar = Repo.month_calendar!(Event, {2016, 1})
    prev = Repo.month_calendar!(Event, Map.get(calendar, :prev)) |> Map.get(:params)

    assert prev.day == 1
    assert prev.month == 12
    assert prev.year == 2015
  end

end
