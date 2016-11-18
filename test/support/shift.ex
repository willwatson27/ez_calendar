defmodule EZCalendar.Shift do
  use Ecto.Schema

  schema "shifts" do
    field :employee, :string
    
    field :date, Ecto.Date
    field :datetime, Ecto.DateTime
    
    field :starting, Ecto.DateTime
    field :ending, Ecto.DateTime

    timestamps
  end

end