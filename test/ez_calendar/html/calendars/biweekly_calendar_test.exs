defmodule EZCalendar.HTML.BiweeklyCalendarTest do
  use ExUnit.Case, async: true
  alias EZCalendar.HTML.BiweeklyCalendar

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(EZCalendar.Repo)
  end
 
  test "renders a biweekly calendar" do
    html = EZCalendar.Fixtures.BiweeklyCalendar.calendar
    |> EZCalendar.FixtureHelpers.calendar_html(BiweeklyCalendar)

    assert html == EZCalendar.Fixtures.BiweeklyCalendar.html
  end
end