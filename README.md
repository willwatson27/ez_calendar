# EZCalendar

**Turn your Ecto queries into calendar style data structures!**
 * Includes view helpers for server side rendering in Phoenix
 * Tested with Ecto, Calecto and TimexEcto

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

## Usage
Turn your queries into calendar structs
```elixir
def calendar(params \\ DateTime.utc_now) do
  MyApp.Shift
  |> with_employee
  |> MyApp.Repo.month_calendar(params)
end
```
Month, week, day and biweekly calendars exist and can be called with their respective functions or by passing the module in as an argument to `Repo.calendar/4`. 
All Repo functions have a bang**!** variant that will raise an error rather than returning a tuple.

The params can be a Date, DateTime, erl style tuple or map containing the keys `day` `month` and `year`. 
The day can be ommited from the params, doing so will result in the first of the month being used.
Tuple and map values will be cast as integers for easy integration with phoenix.

```elixir
Repo.day_calendar(query, %{day: 1, month: 11, year: 2016})
Repo.week_calendar(query, {2016, 11, 27})
Repo.month_calendar(query, {2016, 11})
Repo.biweekly_calendar(query, {2016, 11, 3})
# Custom calendar modules can be defined.
Repo.calendar(query, MyApp.PayrollCalendar, params)
# Examples  lib/ez_calendar/calendars/
# Behaviour lib/ez_calendar/calendars/calendar.ex
```
The timezone and query field can be set with `:tz` and `:field` as options. 
If using a biweekly calendar the `biweekly_start` can also be set.
Default values for the options can be set in the config.

```elixir
Repo.biweekly_calendar(
  query, 
  params, 
  field: [:starting, :ending], 
  tz: "America/Vancouver", 
  biweekly_start: {2016, 1, 4}
)

```
The `field` option represents field name in your schema used to build the calendars.
It can be a single field, or 2 item list or tuple representing a start/end range. 
Date or DateTime types are valid, if using a range the types must match.

The timezone defaults to `UTC` and must a be valid TZ data format. It's used to appropriately set each dates `today?` boolean flag. 

The `biweekly_start` must be an erl equal to the first day in any of the two week periods you want the calendar to represent. 
Can start on any day of the week. 
## Multiple Queries
You can use a keyword list for the query. Each query will use the default field(s) unless provided in the query list or in the options.
```elixir
[
  shifts: [Shift, [:starting, :ending]],
  events: [Event, :starting_at],
  meetings: Meeting,
  deliveries: Delivery
]
|> Repo.month_calendar({2016, 11}, field: :scheduled_for)
```

Query results will be accessible by their key in each dates data field:
```elixir
[
  # ...
  %{
    data: %{
      shifts: [%Shift{}, %Shift{}],
      events: [%Event{}],
      meetings: [],
      deliveries: [%Delivery{}]
    },
    day: 18, 
    month: 11, 
    today?: true, 
    weekday: "Friday", 
    year: 2016
  },
  # ...
]
```
## Phoenix

Install one of the stylesheet formats.

```
$ mix ez_calendar.css
$ mix ez_calendar.scss
$ mix ez_calendar.sass
```

Build a calendar from the params.
```elixir
def index(conn, params) do
  case MyApp.Repo.month_calendar(MyApp.Shift, params) do
    {:ok, calendar} ->
      render(conn, "index.html", calendar: calendar)

    {:error, reason} ->
      calendar = MyApp.Repo.month_calendar!(MyApp.Shift, DateTime.utc_now)

      conn
      |> put_flash(:error, reason)
      |> render("index.html", calendar: calendar)
  end
end
```

Import the view helpers.
```elixir
defmodule MyApp.ShiftView do
  use MyApp.Web, :view
  import EZCalendar.HTML
end
```

Render the calendar with the view helpers.
```eex
<%= calendar_prev @calendar, "/shifts/:year/:month" %>
<%= @calendar.title %>
<%= calendar_next @calendar, "/shifts/:year/:month" %>

<%= render_calendar @calendar, fn(date)-> %>
  <!-- calendar date -->
  <%= for shift <- date.data do %>
    <!-- query results for date -->
  <% end %> 
<% end %> 
```
If you want to use an html module that is not the default for that calendar,
you can use the `render_calendar/3` function to pass in the module as the first arugument.
```eex
<%= render_calendar MyApp.CustomMonthCalendar, @calendar, fn(date)-> %>
<% end %>
# Custom HTML modules can be defined.
# Examples  lib/ez_calendar/html/calendars/
# Behaviour lib/ez_calendar/html/calendars/calendar.ex
```
The `calendar_next` and `calendar_prev` functions accept the 
calendar struct and a string showing how to format the path. 
The correct parameters will replace the `:day`, `:month` and `:year` placeholders.

The links contents can also be passed in as an optional third argument.
```eex

<%= calendar_next @calendar, "/shifts/:year/:month/:day", "Next" %>

<%= calendar_next @calendar, "/shifts/:year/:month", fn()-> %>
  <!-- link content -->
<% end %>

<%= calendar_next @calendar, "/shifts?year=:year&month=:month", "Next" %>
```

## Configuration
The following values are the defaults.
```elixir
config :ez_calendar, 
  default_field: :date, 
  default_tz: "UTC", 
  default_next: ">",      
  default_prev: "<",   
  default_biweekly_start: {2016, 1, 3} 
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