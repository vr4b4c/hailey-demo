defmodule Hailey.Recurrence.Server do
  use GenServer, restart: :transient

  @type callback :: {module(), term()} | {module(), atom(), term()}

  @spec start_link(schedule: Cocktail.Schedule.t(), uid: term(), callback: callback)
  :: GenServer.on_start()
  def start_link(schedule: schedule, uid: uid, callback: callback) do
    GenServer.start_link(
      __MODULE__,
      {schedule, uid, callback},
      name: via_tuple(uid)
    )
  end

  @spec cancel(term()) :: :ok
  def cancel(uid) do
    GenServer.cast(via_tuple(uid), :cancel)
  end

  @impl true
  def init({schedule, uid, callback}) do
    {:ok,
      %{schedule: schedule, uid: uid, callback: callback},
      {:continue, :schedule_first_tick}
    }
  end

  @impl true
  def handle_info({:tick, ts}, state) do
    notify(state, ts)
    schedule_next_occurence(state, ts)
  end

  @impl true
  def handle_continue(:schedule_first_tick, state) do
    schedule_next_occurence(state, DateTime.utc_now())
  end

  @impl true
  def handle_cast(:cancel, state) do
    {:stop, {:shutdown, :cancel}, state}
  end

  defp via_tuple(uid) do
    Hailey.Recurrence.Registry.via_tuple({__MODULE__, uid})
  end

  defp schedule_next_occurence(state, last_occurrence_at) do
    now = DateTime.utc_now()
    occurrences = Cocktail.Schedule.occurrences(state.schedule, now)

    case next_occurence(occurrences, now, last_occurrence_at) do
      {:ok, ts} ->
        timeout =
          ts
          |> DateTime.diff(DateTime.utc_now(), :millisecond)
          |> max(1)

        Process.send_after(self(), {:tick, ts}, timeout)
        {:noreply, state}
      {:error, :done} ->
        {:stop, {:shutdown, :done}, state}
    end
  end

  defp next_occurence(occurrences, now, last_occurrence_at) do
    ts = Enum.at(occurrences, 0)

    cond do
      is_nil(ts) ->
        {:error, :done}
      DateTime.compare(ts, last_occurrence_at) == :gt ->
        {:ok, ts}
      true ->
        next_occurence(Stream.drop(occurrences, 1), now, last_occurrence_at)
    end
  end

  defp notify(state, ts) do
    spawn(fn() -> invoke(state.callback, ts) end)
  end

  defp invoke({module, func}, ts) do
    apply(module, func, [ts])
  end

  defp invoke({module, func, args}, ts) do
    apply(module, func, [args, ts])
  end
end
