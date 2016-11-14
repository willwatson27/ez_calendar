defmodule EZCalendar.HTML.DayCalendarTest do
  use ExUnit.Case
  alias EZCalendar.HTML.DayCalendar

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(EZCalendar.Repo)
  end
 
  test "renders a day calendar" do
    html = EZCalendar.Fixtures.DayCalendar.calendar
    |> EZCalendar.FixtureHelpers.calendar_html(DayCalendar)
    
    assert html == EZCalendar.Fixtures.DayCalendar.html
  end
end