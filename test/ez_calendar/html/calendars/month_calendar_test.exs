defmodule EZCalendar.HTML.MonthCalendarTest do
  use ExUnit.Case, async: true
  alias EZCalendar.Fixtures.{MonthCalendar, Helpers}

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(EZCalendar.Repo)
  end
 
  test "renders a month calendar" do
    html = Helpers.calendar_html(MonthCalendar)

    assert html == MonthCalendar.html
  end
end