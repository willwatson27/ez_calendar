# EZCalendar

Turns Ecto queries into calendar data structures. Includes view helpers for server side rendering in Phoenix. 

## Installation

This package is [available in Hex](https://hex.pm/packages/ez_calendar) and can be installed as:

Add `ez_calendar` to your list of dependencies in `mix.exs`:
```elixir
def deps do
  [{:ez_calendar, "~> 0.1.0"}]
end

def application do
  [applications: [:ez_calendar]]
end
```

Add EZCalendar to your `repo.ex`:
```elixir
defmodule MyApp.Repo do
  use Ecto.Repo, otp_app: :my_app
  use EZCalendar
end
```

## Basic Usage
Turn your queries into calendar structs 
```elixir
def calendar date \\ DateTime.utc_now do
  Shift
  |> with_employee
  |> Repo.month_calendar(date)
end
```
Repo functions accept an ecto query as the first argument and a Date, DateTime, erl, tuple `{year, month, day}` or map as the second. The day can be ommited on month calendars, doing so with others will result in the 1st of the month being used.
```elixir
Repo.day_calendar(query, %{day: 1, month: 11, year: 2016})
Repo.week_calendar(query, {2016, 11, 27})
Repo.month_calendar(query, {2016, 11})
```

Month, week and day calendars exist and can be called with their respective functions or by passing the module in as an argument to `Repo.calendar/4`

Custom calendar modules can also be defined, for examples check `lib/calendars`, behaviour is defined in `lib/calendars/calendar.ex`
```elixir
Repo.calendar(query, MyApp.PayrollCalendar, params, opts)
```

## Phoenix

Build a calendar from the params
```elixir
def index(conn, params) do
  calendar = Shift |> Repo.month_calendar(params)
  render(conn, "index.html", calendar: calendar)
end
```

Import view helpers
```elixir
defmodule MyApp.EmployeeView do
  use MyApp.Web, :view
  import EZCalendar.HTML
end
```

Generate the calendar using the view helpers
```elixir
<%= month_calendar @conn, @calendar, fn(date)-> %>
  <%= for shift <- date.data do %>
    ...
  <% end %>
<% end %>
```
Like the repo functions, there are render functions for each of the built in calendars. You can also use the `calendar/4` function to pass in the HTML module as an arugument
```elixir
<%= calendar MyApp.PayrollCalendar.HTML, @conn, @calendar, fn(date)-> %>
<% end %>
```

## Configuration
```elixir
config :ez_calendar, 
  default_tz: "UTC",    # default / TZ data format / used to add "today" flag
  default_field: :date   # default / date type / schema accessor for building calendar structs
```
Can also be changed on a per query basis
```elixir
Repo.month_calendar(query, date, field: :posted_on, tz: "America/Vancouver")
```

## Contributing
Fork it and submit a pull request, help is very welcome!