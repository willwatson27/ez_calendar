defmodule EZCalendar.FixtureHelpers do
  use Phoenix.HTML

  def calendar_html calendar, module do
    calendar
    |> module.build(fn(date)->
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
