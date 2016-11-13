defmodule EZCalendar.Calendar do

  @moduledoc """
  Behaviour definition for calendar types.
  """

  @type date :: String.t
  @type dates :: list

  # Accepts a date erl and returns a 2 item tuple with the start and end date for the calendar. 
  @callback date_range(date) :: [tuple]

  # Accepts the calendar dates and the date from the original query and returns a celendar struct.
  @callback build(dates, date) :: [any]
end