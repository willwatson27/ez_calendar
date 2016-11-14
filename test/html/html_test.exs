defmodule EZCalendar.HTMLTest do
  use ExUnit.Case
  alias EZCalendar.HTML

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(EZCalendar.Repo)
  end

  defp build_calendar calendar_module do
    EZCalendar.Event |> EZCalendar.Repo.calendar!(calendar_module, {3016, 11, 1})
  end
 
  test "cal" do
    calendar = build_calendar(EZCalendar.MonthCalendar)
    html = HTML.calendar(EZCalendar.HTML.MonthCalendar, calendar, fn(_)-> " " end)

    {result, _} = html
    assert result == :safe
  end
 
  test "month" do
    calendar = build_calendar(EZCalendar.MonthCalendar)
    html = HTML.month_calendar(calendar, fn(_)-> " " end)

    {result, _} = html
    assert result == :safe
  end
 
  test "week" do
    calendar = build_calendar(EZCalendar.WeekCalendar)
    html = HTML.week_calendar(calendar, fn(_)-> " " end)

    {result, _} = html
    assert result == :safe
  end
 
  test "day" do
    calendar = build_calendar(EZCalendar.DayCalendar)
    html = HTML.day_calendar(calendar, fn(_)-> " " end)

    {result, _} = html
    assert result == :safe
  end
end