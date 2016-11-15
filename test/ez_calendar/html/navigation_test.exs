defmodule EZCalendar.HTML.NavigationTest do
  use ExUnit.Case, async: true
  alias EZCalendar.{Repo, Event}
  alias EZCalendar.HTML.Navigation

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(EZCalendar.Repo)
  end

  test "builds a next link" do
    link_html = Event 
    |> Repo.month_calendar!({2016, 11, 1})
    |> Navigation.calendar_next("/events/:year/:month")
    |> Phoenix.HTML.safe_to_string
    
    valid_html = """
    <a class="calendar-next" href="/events/2016/12">&gt;</a>\
    """

    assert link_html == valid_html
  end

  test "builds a prev link" do
    link_html = Event 
    |> Repo.month_calendar!({2016, 11, 1})
    |> Navigation.calendar_prev("/events/:year/:month")
    |> Phoenix.HTML.safe_to_string
    
    valid_html = """
    <a class="calendar-prev" href="/events/2016/10">&lt;</a>\
    """

    assert link_html == valid_html
  end

  test "accepts optional render string" do
    link_html = Event 
    |> Repo.day_calendar!({2016, 11, 1})
    |> Navigation.calendar_next("/events/:year/:month/:day", "Next")
    |> Phoenix.HTML.safe_to_string

    valid_html = """
    <a class="calendar-next" href="/events/2016/11/2">Next</a>\
    """
    
    assert link_html == valid_html
  end

  test "accepts optional render function" do
    link_html = Event 
    |> Repo.week_calendar!({2016, 11, 1})
    |> Navigation.calendar_next("/events/:year/:month/:day", fn()-> "HTML content block" end)
    |> Phoenix.HTML.safe_to_string

    valid_html = """
    <a class="calendar-next" href="/events/2016/11/8">HTML content block</a>\
    """

    assert link_html == valid_html
  end

end