defmodule EZCalendar.BiweeklyCalendarTest do
  use ExUnit.Case
  alias EZCalendar.{Repo, Event, BiweeklyCalendar}

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(EZCalendar.Repo)
  end

  defp build_calendar date, payroll_start \\ nil do
    if payroll_start do
      Event |> Repo.calendar!(BiweeklyCalendar, date, biweekly_start: payroll_start)
    else
      Event |> Repo.calendar!(BiweeklyCalendar, date)
    end
  end

  defp assert_date(struct, {year, month, day}) do
    assert struct.year == year
    assert struct.month == month
    assert struct.day == day
  end

  test "returns the correct date range" do
    {start_date, end_date} = BiweeklyCalendar.date_range({2016, 1, 3}, [])
    assert start_date == ~D[2016-01-03]
    assert end_date == ~D[2016-01-16]

    {start_date, end_date} = BiweeklyCalendar.date_range({2016, 1, 20}, [])
    assert start_date == ~D[2016-01-17]
    assert end_date == ~D[2016-01-30]

    {start_date, end_date} = BiweeklyCalendar.date_range({2015, 12, 31}, [])
    assert start_date == ~D[2015-12-20]
    assert end_date == ~D[2016-01-02]
  end

  test "can take a biweekly_start option" do
    dates = build_calendar({2016, 1, 3}, {2016, 1, 4}) |> Map.get(:dates) |> List.flatten
    date = dates |> List.first
    assert_date(date, {2016, 1, 4})
  end

  test "returns a struct with the correct params" do
    params = build_calendar({2016, 1, 3}) |> Map.get(:params)
    assert_date(params, {2016, 1, 3})
  end 

  test "returns a struct with the correct title" do
    title = build_calendar({2016, 1, 3}) |> Map.get(:title)
    assert title == "03 Jan 2016 - 16 Jan 2016"
  end

  test "returns a struct with the correct next" do
    next = build_calendar({2016, 1, 3}) |> Map.get(:next)
    assert_date(next, {2016, 1, 17})
  end

  test "returns a struct with the correct prev" do
    prev = build_calendar({2016, 1, 3}) |> Map.get(:prev)
    assert_date(prev, {2015, 12, 20})
  end

  test "returns a struct with the correct dates" do
    dates = build_calendar({2016, 1, 3}) |> Map.get(:dates) |> List.flatten
    start_date = dates |> List.first
    end_date = dates |> List.last

    assert_date(start_date, {2016, 1, 3})
    assert_date(end_date, {2016, 1, 16})
  end
end