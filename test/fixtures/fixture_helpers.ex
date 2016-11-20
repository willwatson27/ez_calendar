defmodule EZCalendar.Fixtures.Helpers do
  @moduledoc false
  use Phoenix.HTML

  def calendar_html module do
    module.calendar
    |> EZCalendar.HTML.render_calendar(fn(date)->
      [
        content_tag(:div, "Date Content"),
        content_tag(:div) do
          Enum.map(date.data, fn(_)-> 
            "Event Content"
          end)
        end
      ]
    end)
    |> Phoenix.HTML.safe_to_string  
  end
  
end
