defmodule EZCalendar.ParamParserTest do
  use ExUnit.Case
  alias EZCalendar.Repo
  alias EZCalendar.Event
  alias EZCalendar.ParamParser

  alias EZCalendar.{MonthCalendar, DayCalendar}

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(EZCalendar.Repo)
  end


  test "params can be an erl/tuple" do
    calendar = Event |> Repo.calendar(DayCalendar, {2016, 11, 1})
    assert calendar.__struct__ == DayCalendar    
  end


  test "params can be a map containing the day month and year" do
    calendar = Event |> Repo.calendar(MonthCalendar, %{day: 1, month: 10, year: 2016})
    assert calendar.__struct__ == MonthCalendar    
    calendar = Event |> Repo.calendar(MonthCalendar, %{"day" => 1, "month" => 10, "year" => 2016})
    assert calendar.__struct__ == MonthCalendar    
  end

  test "param values can be strings" do
     calendar = Event |> Repo.calendar(MonthCalendar, %{"day" => "2016", "month" => "10", "year" => "2016"})
    assert calendar.__struct__ == MonthCalendar      
  end

  test "params can be a DateTime" do
    calendar = Event |> Repo.calendar(MonthCalendar, DateTime.utc_now)
    assert calendar.__struct__ == MonthCalendar       
  end

  test "params can be a date ~D[2016-11-1]" do
    calendar = Event |> Repo.calendar(MonthCalendar, ~D[2016-11-01])
    assert calendar.__struct__ == MonthCalendar       
  end

  test "the day can be ommited on month calendars" do
    calendar = Event |> Repo.calendar(MonthCalendar, {2016, 11})
    assert calendar.__struct__ == MonthCalendar    
  end

  test "converts an erl into a map" do
    date = ParamParser.to_params({2016, 11, 1})

    assert date.day == 1
    assert date.month == 11
    assert date.year == 2016
  end

end