defmodule Hailey.Simulation do
  def start(params) do
    count = String.to_integer(Map.get(params, "count", "10"))

    create_schedules(count)
  end

  def stop do
    Hailey.Scheduling.Operation.down
    Hailey.Repo.delete_all(Hailey.Scheduling.Schedule)
  end

  defp create_schedules(count) do
    now = DateTime.truncate(DateTime.utc_now(), :second)
    second_from_now = DateTime.add(now, 1, :second)

    Enum.each(1..count, fn(sequence) ->
      time = if rem(sequence, 2) == 0, do: now, else: second_from_now

      sequence
      |> create_schedule!(time)
      |> Hailey.Scheduling.Operation.start_recurrence()
    end)
  end

  defp create_schedule!(sequence, start_at) do
    Hailey.Repo.insert!(
      %Hailey.Scheduling.Schedule{
        sequence: sequence,
        start_at: start_at,
        frequency: "secondly",
        interval: 2
      }
    )
  end
end
