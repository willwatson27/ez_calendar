defmodule EZCalendar.Calendar do

  @moduledoc """
  Behaviour definition for calendar types.
  """

  @type date :: String.t
  @type dates :: list
  @type calendar :: struct
  @type opts :: list

  @doc """
  Returns a 2 item Date type tuple representing the start and end date for the calendar.
  Accepts a date erl and the options
  """  
  
  @callback date_range(date, opts) :: [tuple]

  @doc """
  Accepts the merged calendar dates and the date from the original repo function call params arg.

  Returns a calendar struct should include the following fields: 

  :title - a string defining the date range

  :dates - the list of merged calendar dates

  :params - a param map for the current date period

  :next - a param map for the next date period

  :prev - a param map for the previous date period

  """
  @callback build(dates, date) :: [calendar]
end