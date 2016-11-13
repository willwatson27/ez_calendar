defmodule EZCalendarTest do
  use ExUnit.Case
  alias EZCalendar.Repo
  alias EZCalendar.Event
  doctest EZCalendar

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(EZCalendar.Repo)
  end



end
