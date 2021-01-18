defmodule Hailey.Repo.Migrations.CreateSchedule do
  use Ecto.Migration

  def change do
    create table :schedules, primary_key: false do
      add :id, :uuid, primary_key: true
      add :start_at, :utc_datetime
      add :end_at, :utc_datetime
      add :canceled_at, :utc_datetime
      add :frequency, :string
      add :interval, :integer
      add :count, :integer
      add :days, {:array, :integer}
      add :hours, {:array, :integer}
      add :minutes, {:array, :integer}
      add :seconds, {:array, :integer}
      add :sequence, :integer
      add :times, :map

      timestamps()
    end
  end
end
