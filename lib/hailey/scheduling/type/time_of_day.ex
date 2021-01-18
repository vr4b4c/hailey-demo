defmodule Hailey.Scheduling.Type.TimeOfDay do
  @behaviour Ecto.Type

  def type do
    :map
  end

  def cast(%{"hour" => hour, "minute" => min}) when hour in 0..23 and min in 0..59 do
    {:ok, %{hour: hour, minute: min}}
  end

  def cast(_) do
    :error
  end

  def load(data) do
    %{hour: data["hour"], minute: data["minute"]}
  end

  def dump(%{hour: _hour, minute: _minute} = time_of_day) do
    {:ok, time_of_day}
  end

  def dump(_) do
    :error
  end
end
