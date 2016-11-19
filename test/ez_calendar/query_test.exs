defmodule EZCalendar.QueryRunnerTest do
  use ExUnit.Case
  alias EZCalendar.{QueryRunner, Repo, Shift, Event}

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(EZCalendar.Repo)
  end

  defp run query, start_date, end_date, opts \\ [] do
    QueryRunner.run(query, Repo, start_date, end_date, opts)
  end

  defp ecto_datetime({year, month, day}) do
    Ecto.DateTime.from_erl({{year, month, day}, {0, 0, 0}})
  end

  test "can accept a single query" do
    %Shift{date: Ecto.Date.cast!({2016, 11, 01}) } |> Repo.insert!

    query = run(Shift, ~D[2016-11-01], ~D[2016-11-01])
    shift = query |> Map.get(:results) |> List.first

    assert shift.__struct__ == Shift
  end

  test "can accept a keyword list of queries" do
    %Shift{starting: ecto_datetime({2016, 11, 01}), ending: ecto_datetime({2016, 11, 01}) } |> Repo.insert!
    %Event{date: Ecto.Date.cast!({2016, 11, 01}), posted_on: Ecto.Date.cast!({2016, 11, 01}) } |> Repo.insert!

    queries = [
      shifts: [Shift, [:starting, :ending]],
      events: Event,
      events_posted: [Event, :posted_on],
    ]
    |> run(~D[2016-11-01], ~D[2016-11-01])
    
    shift = queries |> List.first |> Map.get(:results) |> List.first
    event = queries |> List.last |> Map.get(:results) |> List.first

    assert shift.__struct__ == Shift
    assert event.__struct__ == Event
  end

  test "can accept the field as an option" do
    %Event{posted_on: Ecto.Date.cast!({2016, 10, 01}) } |> Repo.insert!
    %Event{posted_on: Ecto.Date.cast!({2016, 11, 01}) } |> Repo.insert!
    
    results = run(Event, ~D[2016-10-31], ~D[2016-11-03], field: :posted_on)
    |> Map.get(:results)

    assert Enum.count(results) == 1
  end

  test "can accept a {start, end} tuple for the field as an option" do
    %Shift{starting: ecto_datetime({2016, 10, 01}), ending: ecto_datetime({2016, 10, 02}) } |> Repo.insert!
    %Shift{starting: ecto_datetime({2016, 11, 01}), ending: ecto_datetime({2016, 11, 02}) } |> Repo.insert!
    
    results = run(Shift, ~D[2016-10-31], ~D[2016-11-03], field: [:starting, :ending])
    |> Map.get(:results)

    assert Enum.count(results) == 1
  end

end