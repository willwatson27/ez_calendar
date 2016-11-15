defmodule EZCalendar.HTML.WeekCalendarTest do
  use ExUnit.Case, async: true
  alias EZCalendar.HTML.WeekCalendar

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(EZCalendar.Repo)
  end
 
  test "renders a week calendar" do
    html = EZCalendar.Fixtures.WeekCalendar.calendar
    |> EZCalendar.FixtureHelpers.calendar_html(WeekCalendar)

    assert html == EZCalendar.Fixtures.WeekCalendar.html
  end
end