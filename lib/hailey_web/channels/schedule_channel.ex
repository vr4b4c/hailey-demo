defmodule HaileyWeb.ScheduleChannel do
  use Phoenix.Channel

  def join("schedule", _payload, socket) do
    {:ok, Hailey.Scheduling.Repository.active_ids(), socket}
  end
end
