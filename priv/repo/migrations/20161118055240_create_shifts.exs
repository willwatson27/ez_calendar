defmodule EZCalendar.Repo.Migrations.CreateShifts do
  use Ecto.Migration

  def change do
    create table(:shifts) do
      add :employee, :string
      add :date, :date
      add :datetime, :datetime
      add :starting, :datetime
      add :ending, :datetime

      timestamps()
    end
  end
end
