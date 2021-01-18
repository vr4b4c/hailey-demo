defmodule Hailey.Notifications.Job do
  def schedule(schedule, ts) do
    #   IO.inspect({ts, schedule})
    HaileyWeb.Endpoint.broadcast!("schedule", "tick", %{
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
        times: schedule.times,
        sequence: schedule.sequence
      },
      timestamp: ts
    })
  end
end
