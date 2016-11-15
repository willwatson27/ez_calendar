defmodule EZCalendar.ParamParserTest do
  use ExUnit.Case, async: true
  alias EZCalendar.ParamParser

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(EZCalendar.Repo)
  end

  ###
  # to_erl
  ###

  test "returns an ok tuple for valid dates" do
    {:ok, erl} = ParamParser.to_erl(%{"day" => "1", "month" => "11", "year" => "2016"})
    assert erl == {2016, 11, 1}
  end

  test "returns an error tuple for invalid dates" do
    {response, _} = ParamParser.to_erl({2016, 99, 99})
    assert response == :error  
  end

  test "params can be an erl/tuple" do
    {:ok, date} = ParamParser.to_erl({2016, 11, 1})
    assert date == {2016, 11, 1}       
  end

  test "erl/tuple can be strings" do
    {:ok, date} = ParamParser.to_erl({"2016", "11", "15"})
    assert date == {2016, 11, 15}       
  end

  test "params can be a map containing the day month and year" do
    {:ok, date} = ParamParser.to_erl(%{day: 1, month: 10, year: 2016})
    assert date == {2016, 10, 1}
    {:ok, date} = ParamParser.to_erl(%{"day" => 1, "month" => 10, "year" => 2016})
    assert date == {2016, 10, 1}     
  end

  test "param values can be strings" do  
    {:ok, date} = ParamParser.to_erl(%{"day" => "1", "month" => "10", "year" => "2016"})
    assert date == {2016, 10, 1}
  end

  test "params can be a DateTime type" do
    {response, _} = ParamParser.to_erl(DateTime.utc_now)
    assert response == :ok    
  end

  test "params can be a Date type" do
    {:ok, date} = ParamParser.to_erl(~D[2016-11-03])
    assert date == {2016, 11, 3}
  end

  test "missing day param returns the first of the month" do
    {:ok, {_, _, day}} = ParamParser.to_erl({2016, 11})
    assert day == 1 
  end

  ###
  # to_params
  ###

  test "converts an erl into a map" do
    date = ParamParser.to_params({2016, 11, 1})

    assert date.day == 1
    assert date.month == 11
    assert date.year == 2016
  end

end