defmodule EZCalendar.HTML.BiweeklyCalendarTest do
  use ExUnit.Case, async: true
  alias EZCalendar.Fixtures.{BiweeklyCalendar, Helpers}

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(EZCalendar.Repo)
  end
 
  test "renders a biweekly calendar" do
    html = Helpers.calendar_html(BiweeklyCalendar)

    assert html == BiweeklyCalendar.html
  end
end