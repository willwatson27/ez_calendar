defmodule EZCalendar.HTML.Calendar do

  @moduledoc """
  Behaviour definition for HTML calendar types.
  """

  @type calendar :: struct
  @type render_function :: fun

  @doc """
  Builds the html for a calendar struct, accepts a calendar and a function as arugments.

  The function can be passed in from the view and used to render the content for each date.
  """  

  @callback build(calendar, render_function) :: [any]
end