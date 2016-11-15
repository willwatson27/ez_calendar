defmodule EZCalendar.HTML.MonthCalendarTest do
  use ExUnit.Case, async: true
  alias EZCalendar.HTML.MonthCalendar

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(EZCalendar.Repo)
  end
 
  test "renders a month calendar" do
    html = EZCalendar.Fixtures.MonthCalendar.calendar
    |> EZCalendar.FixtureHelpers.calendar_html(MonthCalendar)

    assert html == EZCalendar.Fixtures.MonthCalendar.html
  end
end