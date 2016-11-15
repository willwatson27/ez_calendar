# EZCalendar

Turns Ecto queries into calendar data structures. Includes view helpers for server side rendering in Phoenix. 

## Installation

This package is [available in Hex](https://hex.pm/packages/ez_calendar)
Add `ez_calendar` to your `mix.exs` file
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

Month, week and day calendars exist and can be called with their respective functions or by passing the module in as an argument to `Repo.calendar/4`. Additionally, all Repo functions have a bang **!** variant.

Custom calendar modules can be defined, for examples check `lib/calendars`, behaviour is defined in `lib/calendars/calendar.ex`
```elixir
Repo.calendar(query, MyApp.PayrollCalendar, params, opts)
```

## Phoenix

Install the stylesheets.

```
$ mix ez_calendar.css
```

Build a calendar from the params
```elixir
def index(conn, params) do
  case Repo.month_calendar(Shift, params) do
    {:ok, calendar} ->
      render(conn, "index.html", calendar: calendar)

    {:error, reason} ->
      calendar = Repo.month_calendar!(Shift, DateTime.utc_now)

      conn
      |> put_flash(:error, reason)
      |> render("index.html", calendar: calendar)
  end
end
```

Import view helpers
```elixir
defmodule MyApp.ShiftView do
  use MyApp.Web, :view
  import EZCalendar.HTML
end
```

Build a calendar using the view helpers
```eex
<%= calendar_prev @calendar, "/shifts/:year/:month" %>
<%= @calendar.title %>
<%= calendar_next @calendar, "/shifts/:year/:month" %>

<%= month_calendar @calendar, fn(date)-> %>
  <!-- calendar date -->
  <%= for shift <- date.data do %>
    <!-- query results for date -->
  <% end %> 
<% end %> 
```
Like the repo functions, there are render functions for each of the built in calendars. You can also use the `calendar/3` function to pass in the HTML module as an arugument.
```eex
<%= calendar MyApp.PayrollCalendar.HTML, @calendar, fn(date)-> %>
<% end %>
```

The next and previous functions accept the calendar and a string showing how to format the path. The correct parameters will replace :day, :month and :year. 
They will also accept a function or string as an optional third argument
```eex
<%= calendar_prev @calendar, "/shifts/:year/:month", "Previous" %>

<%= calendar_next @calendar, "/shifts/:year/:month", fn()-> %>
  <!-- link content -->
<% end %>
```

## Configuration
```elixir
config :ez_calendar, 
  default_tz: "UTC",      # default / TZ data format / used to add "today" flag
  default_field: :date,   # default / date type / schema accessor for building calendar structs
  default_next: ">",      # default text for navigation links
  default_prev: "<",   
```
The field and timezone can also be changed on a per query basis
```elixir
Repo.month_calendar(query, date, field: :posted_on, tz: "America/Vancouver")
```

## Contributing
Help is very welcome! Please make sure all the tests are passing before submitting a pull request.

Setup the database
```
$ MIX_ENV=test mix ecto.create && mix ecto.migrate
```
Run the tests!
```
$ mix test
```