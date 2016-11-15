defmodule EZCalendar.CalendarBuilderTest do
  use ExUnit.Case, async: true
  alias EZCalendar.Repo
  alias EZCalendar.Event
  alias EZCalendar.CalendarBuilder

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(EZCalendar.Repo)
  end

  defp build_dates start_date, end_date, opts \\ [] do
    CalendarBuilder.build(Event, Repo, start_date, end_date, opts)
  end

  defp create_event date, posted_on \\ nil do
    posted = posted_on || date
    %Event{ title: "Event", date: Date.from_erl!(date) |> Ecto.Date.cast!, posted_on: Date.from_erl!(posted) |> Ecto.Date.cast! } 
    |> Repo.insert!
  end
 
  test "calendar dates have a today? flag" do
    today = DateTime.utc_now |> DateTime.to_date
    date = build_dates(today, today) |> List.first

    assert date.today? == true
  end

  test "calendar dates include the weekday" do
    date = build_dates(~D[2016-10-30], ~D[2016-11-03]) |> List.first

    assert date.weekday == "Sunday"
  end

  test "calendar dates include date information" do
    date = build_dates(~D[2016-10-30], ~D[2016-11-03]) |> List.first

    assert date.day == 30
    assert date.month == 10
    assert date.year == 2016
  end

  test "calendar dates include query results for that day" do
    create_event({2016, 10, 30})
    create_event({2016, 11, 3})
    dates = build_dates(~D[2016-10-30], ~D[2016-11-03])
    
    data1 = List.first(dates) |> Map.get(:data) |> List.first
    data2 = List.last(dates) |> Map.get(:data)  |> List.first

    assert data1.__struct__ == EZCalendar.Event
    assert Ecto.Date.to_erl(data1.date) == {2016, 10, 30}
    assert Ecto.Date.to_erl(data2.date) == {2016, 11, 3}
  end

  test "calendars can be built from a given field" do
    create_event({2017, 10, 30}, {2016, 10, 30})
    create_event({2017, 11, 3}, {2016, 11, 3})
    dates = build_dates(~D[2016-10-30], ~D[2016-11-03], field: :posted_on)
    
    data1 = List.first(dates) |> Map.get(:data) |> List.first
    data2 = List.last(dates) |> Map.get(:data)  |> List.first

    assert data1.__struct__ == EZCalendar.Event
    assert Ecto.Date.to_erl(data1.posted_on) == {2016, 10, 30}
    assert Ecto.Date.to_erl(data2.posted_on) == {2016, 11, 3}
  end

end
