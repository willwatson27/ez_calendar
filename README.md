# EZCalendar

**Turn your Ecto queries into calendar style data structures!**
 * Includes view helpers for server side rendering in Phoenix
 * Works with Calecto and TimexEcto

## Installation

This package is [available in Hex](https://hex.pm/packages/ez_calendar).

Add `ez_calendar` to your `mix.exs` file.
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
  MyApp.Shift
  |> with_employee
  |> MyApp.Repo.month_calendar(date)
end
```
Repo functions accept an ecto query as the first argument and a Date, DateTime, erl, tuple `{year, month, day}` or map as the second. The day can be ommited on month calendars, doing so with others will result in the 1st of the month being used.
```elixir
Repo.day_calendar(query, %{day: 1, month: 11, year: 2016})
Repo.week_calendar(query, {2016, 11, 27})
Repo.month_calendar(query, {2016, 11})
Repo.biweekly_calendar(query, {2016, 11, 3})
```

Month, week, day and biweekly calendars exist and can be called with their respective functions or by passing the module in as an argument to `Repo.calendar/4`. Additionally, all Repo functions have a bang **!** variant.

Custom calendar modules can be defined, for examples check `lib/ez_calendar/calendars`, behaviour is defined in `lib/ez_calendar/calendars/calendar.ex`
```elixir
Repo.calendar(query, MyApp.PayrollCalendar, params, opts)
```
### Multiple Queries
You also can build a keyword list of queries.
```elixir
[
  shifts: [Shift, [:starting, :ending]],
  events: [Event, :starting_at],
  meetings: Meeting,
  deliveries: Devlivery
]
|> Repo.day_calendar({2016, 11, 1}, field: :scheduled_for)
```

You will be able to access your query results by key in each dates data field:
```elixir
%{
  data: %{
    shifts: [%Shift{}, %Shift{}],
    events: [%Event{}],
    meetings: [],
    deliveries: [%Devlivery{}]
  },
  day: 1, 
  month: 11, 
  today?: false, 
  weekday: "Tuesday", 
  year: 2016
}
```
## Phoenix

Install one of the stylesheet formats.

```
$ mix ez_calendar.css
$ mix ez_calendar.scss
$ mix ez_calendar.sass
```

Build a calendar from the params
```elixir
def index(conn, params) do
  case Repo.month_calendar(MyApp.Shift, params) do
    {:ok, calendar} ->
      render(conn, "index.html", calendar: calendar)

    {:error, reason} ->
      calendar = Repo.month_calendar!(MyApp.Shift, DateTime.utc_now)

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
Like the repo functions, there are render functions for each of the built in calendars, alternatively you can use the `calendar/3` function to pass in the HTML module as an arugument. Custom HTML modules can be defined too, for examples check `lib/ez_calendar/html/calendars`, behaviour defined in `lib/ez_calendar/html/calendars/calendar.ex`
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
  # schema field name(s) for building calendar structs
  # can be a single field or a start and end tuple/list
  # fields can be date or datetime types
  # defaults to :date
  default_field: [:starting, :ending], 
  
  # TZ data format # used to add "today" flag
  default_tz: "UTC", 
  
  # text for navigation links
  default_next: ">",      
  default_prev: "<",   
  
  # erl type # used to build biweekly date ranges
  default_biweekly_start: {2016, 1, 3} 
```
The field, timezone and biweekly_start date can also be changed on a per query basis
```elixir
Repo.biweekly_calendar(
  MyApp.Shift, 
  DateTime.utc_now, 
  field: {:starting, :ending}, 
  tz: "America/Vancouver", 
  biweekly_start: {2016, 1, 4}
)
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