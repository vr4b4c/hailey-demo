defmodule Hailey.Recurrence.Supervisor do
  use DynamicSupervisor

  @spec start_link(term) :: Supervisor.on_start()
  def start_link(_arg) do
    DynamicSupervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  @impl true
  def init(:ok) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def start_child(args) do
    DynamicSupervisor.start_child(
      __MODULE__,
      {Hailey.Recurrence.Server, args}
    )
  end
end
