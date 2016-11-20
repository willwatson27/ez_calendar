defmodule EZCalendar.HTML.DayCalendarTest do
  use ExUnit.Case, async: true
  alias EZCalendar.Fixtures.{DayCalendar, Helpers}

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(EZCalendar.Repo)
  end
 
  test "renders a day calendar" do
    html = Helpers.calendar_html(DayCalendar)
    
    assert html == DayCalendar.html
  end
end