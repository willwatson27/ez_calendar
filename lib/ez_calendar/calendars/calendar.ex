defmodule EZCalendar.Calendar do

  @moduledoc """
  Behaviour definition for calendar types.
  """

  @type date :: String.t
  @type dates :: list
  @type calendar :: struct
  @type opts :: list

  @doc """
  The first argument is a date erl parsed from the params.

  The second argument is the options.

  Returns a 2 item Date type tuple representing the calendars start and end for the given date.
      {~D[2016-10-30], ~D[2016-11-04]}
  """  
  
  @callback date_range(date, opts) :: [tuple]

  @doc """
  The first argument is a list of calendar dates containing the query results for each respective day.

  The second argument is the date erl parsed from the params.

  Returns a calendar struct that should include the following fields: 

  `:title`  a string defining the current calendar

  `:dates`  the list of date structs

  `:params` a map with the keys `:day`, `:month` and `:year` representing the current date period

  `:next`   a map with the keys `:day`, `:month` and `:year` representing the next date period

  `:prev`   a map with the keys `:day`, `:month` and `:year` representing the previous date period

  You can add extra fields to your calendar but these are required for it to function properly.
  """
  @callback build(dates, date) :: [calendar]
end