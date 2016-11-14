defmodule EZCalendar.Event do
  use Ecto.Schema

  schema "events" do
    field :title, :string
    field :date, Ecto.Date
    field :posted_on, Ecto.Date

    timestamps
  end

end