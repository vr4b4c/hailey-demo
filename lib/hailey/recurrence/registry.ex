defmodule Hailey.Recurrence.Registry do
  @type key :: {:via, Registry, {__MODULE__, term()}}

  @spec start_link(term()) :: GenServer.on_start()
  def start_link(_arg) do
    Registry.start_link(keys: :unique, name: __MODULE__)
  end

  @spec via_tuple(term()) :: key()
  def via_tuple(key) do
    {:via, Registry, {__MODULE__, key}}
  end

  @spec child_spec(term()) :: Supervisor.child_spec()
  def child_spec(args) do
    Supervisor.child_spec(
      Registry,
      id: __MODULE__,
      start: {__MODULE__, :start_link, [args]}
    )
  end
end
