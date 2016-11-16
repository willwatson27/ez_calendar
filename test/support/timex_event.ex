defmodule EZCalendar.TimexEvent do
  use Ecto.Schema

  schema "events" do
    field :title, :string

    field :date, Timex.Ecto.Date
    field :datetime, Timex.Ecto.DateTime

    timestamps
  end

end