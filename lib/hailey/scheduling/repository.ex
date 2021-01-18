defmodule Hailey.Scheduling.Repository do
  import Ecto.Query

  def all_in_order() do
    Hailey.Repo.all(
      from schedule in Hailey.Scheduling.Schedule,
        order_by: [asc: schedule.sequence],
        select: schedule
    )
  end

  def active_ids(now \\ DateTime.utc_now()) do
    Hailey.Repo.all(
      from schedule in Hailey.Scheduling.Schedule,
        where: is_nil(schedule.end_at) or schedule.end_at > ^now,
        order_by: [asc: schedule.sequence],
        select: schedule.id
    )
  end
end
