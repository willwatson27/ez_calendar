defmodule EZCalendar.HTMLTest do
  use ExUnit.Case, async: true
  alias EZCalendar.HTML

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(EZCalendar.Repo)
  end

  defp build_calendar calendar_module do
    EZCalendar.Event |> EZCalendar.Repo.calendar!(calendar_module, {3016, 11, 1})
  end
 
  test "builds a calendar for a given html module" do
    calendar = build_calendar(EZCalendar.MonthCalendar)
    html = HTML.calendar(EZCalendar.HTML.MonthCalendar, calendar, fn(_)-> " " end)

    {result, _} = html
    assert result == :safe
  end
 
  test "builds html for a month calendar" do
    calendar = build_calendar(EZCalendar.MonthCalendar)
    html = HTML.month_calendar(calendar, fn(_)-> " " end)

    {result, _} = html
    assert result == :safe
  end
 
  test "builds html for a week calendar" do
    calendar = build_calendar(EZCalendar.WeekCalendar)
    html = HTML.week_calendar(calendar, fn(_)-> " " end)

    {result, _} = html
    assert result == :safe
  end
 
  test "builds html for a day calendar" do
    calendar = build_calendar(EZCalendar.DayCalendar)
    html = HTML.day_calendar(calendar, fn(_)-> " " end)

    {result, _} = html
    assert result == :safe
  end
end