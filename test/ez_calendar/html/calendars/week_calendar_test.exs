defmodule EZCalendar.HTML.WeekCalendarTest do
  use ExUnit.Case, async: true
  alias EZCalendar.Fixtures.{WeekCalendar, Helpers}

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(EZCalendar.Repo)
  end
 
  test "renders a week calendar" do
    html = Helpers.calendar_html(WeekCalendar)

    assert html == WeekCalendar.html
  end
end