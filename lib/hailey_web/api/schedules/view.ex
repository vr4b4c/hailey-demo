defmodule HaileyWeb.Api.Schedules.View do
  use HaileyWeb, :view

  def render("show.json", %{schedule: schedule}) do
    %{schedule: render_one(schedule, HaileyWeb.Api.Schedules.View, "schedule.json", as: :schedule)}
  end

  def render("schedule.json", %{schedule: schedule}) do
    %{
      id: schedule.id,
      start_at: schedule.start_at,
      end_at: schedule.end_at,
      canceled_at: schedule.canceled_at,
      frequency: schedule.frequency,
      interval: schedule.interval,
      count: schedule.count,
      days: schedule.days,
      hours: schedule.hours,
      minutes: schedule.minutes,
      seconds: schedule.seconds,
      times: schedule.times
    }
  end
end
