defmodule EZCalendar.CalectoEvent do
  use Ecto.Schema

  schema "events" do
    field :title, :string

    field :date, Calecto.Date
    field :datetime, Calecto.DateTimeUTC

    timestamps
  end

end