defmodule EZCalendar.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :title, :string
      add :date, :date
      add :datetime, :datetime
      add :posted_on, :date

      timestamps()
    end

  end
end
