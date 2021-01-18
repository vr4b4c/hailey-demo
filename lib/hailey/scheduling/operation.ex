defmodule Hailey.Scheduling.Operation do
  alias Hailey.Repo

  import Ecto.Query

  def create(params) do
    %Hailey.Scheduling.Schedule{}
    |> Hailey.Scheduling.Schedule.changeset(params)
    |> Repo.insert()
  end

  def start_recurrence(schedule) do
    Hailey.Recurrence.Supervisor.start_child(
      schedule: Hailey.Scheduling.Schedule.cocktail_schedule(schedule),
      uid: schedule.id,
      callback: {Hailey.Notifications.Job, :schedule, schedule}
    )

    HaileyWeb.Endpoint.broadcast!("schedule", "start", %{
      schedule: %{
        id: schedule.id,
        start_at: schedule.start_at,
        end_at: schedule.end_at,
        canceled_at: schedule.canceled_at,
        frequency: schedule.frequency,
        interva: schedule.interval,
        count: schedule.count,
        days: schedule.days,
        hours: schedule.hours,
        minutes: schedule.minutes,
        seconds: schedule.seconds,
        times: schedule.times
      }
    })
  end

  # def warmup do
  #   Hailey.Scheduling.Schedule
  #   |> order_by(asc: :sequence)
  #   |> Hailey.Repo.all()
  #   |> Enum.each(&start_recurrence/1)
  # end

  def up do
    Hailey.Scheduling.Schedule
    |> order_by(asc: :sequence)
    |> Hailey.Repo.all()
    |> Enum.each(&start_recurrence/1)
  end

  def down do
    Hailey.Scheduling.Schedule
    |> order_by(asc: :sequence)
    |> Hailey.Repo.all()
    |> Enum.each(&stop_recurrence/1)
  end

  def stop_recurrence(schedule) do
    Hailey.Recurrence.Server.cancel(schedule.id)
    Hailey.Repo.delete!(schedule)

    HaileyWeb.Endpoint.broadcast!("schedule", "stop", %{
      schedule: %{
        id: schedule.id,
        start_at: schedule.start_at,
        end_at: schedule.end_at,
        canceled_at: schedule.canceled_at,
        frequency: schedule.frequency,
        interva: schedule.interval,
        count: schedule.count,
        days: schedule.days,
        hours: schedule.hours,
        minutes: schedule.minutes,
        seconds: schedule.seconds,
        times: schedule.times
      }
    })
  end
end
