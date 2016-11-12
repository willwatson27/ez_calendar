defmodule EZCalendar.Calendar do
  @type date :: String.t
  @type query :: String.t
  @type dates :: list

  @callback date_range(date) :: [tuple]
  @callback build(dates, date) :: [any]
end