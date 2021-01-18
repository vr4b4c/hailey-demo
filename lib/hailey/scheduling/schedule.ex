defmodule Hailey.Scheduling.Schedule do
  use Ecto.Schema
  import Ecto.Changeset

  alias Hailey.Scheduling.Schedule

  @type t :: %Schedule{}

  @primary_key {:id, :binary_id, autogenerate: true}

  @frequency ["weekly", "daily", "hourly", "minutely", "secondly"]
  @days ["monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday"]
  @hours 0..23
  @minutes 0..59
  @seconds 0..59

  @permitted_attributes [:start_at, :frequency, :interval, :count, :days, :hours, :minutes,
                         :seconds, :times, :sequence]
  @required_attributes [:start_at, :frequency]

  schema "schedules" do
    field :start_at, :utc_datetime
    field :end_at, :utc_datetime
    field :canceled_at, :utc_datetime
    field :frequency, :string
    field :interval, :integer
    field :count, :integer
    field :days, {:array, :string}
    field :hours, {:array, :integer}
    field :minutes, {:array, :integer}
    field :seconds, {:array, :integer}
    field :sequence, :integer
    field :times, {:array,  Hailey.Scheduling.Type.TimeOfDay}

    timestamps()
  end

  def changeset(%Schedule{} = schedule, attrs) do
    schedule
    |> cast(attrs, @permitted_attributes)
    |> validate_required(@required_attributes)
    |> validate_inclusion(:frequency, @frequency)
    |> validate_subset(:days, @days)
    |> validate_subset(:hours, @hours)
    |> validate_subset(:minutes, @minutes)
    |> validate_subset(:seconds, @seconds)
    |> validate_number(:interval, greater_than: 0)
    |> validate_number(:count, greater_than: 0)
    |> terminate()
  end

  def terminate(%Ecto.Changeset{valid?: false} = changeset) do
    changeset
  end

  def terminate(changeset) do
    start_at = get_change(changeset, :start_at)

    put_change(changeset, :end_at, Timex.shift(start_at, months: 1))
  end

  def cocktail_schedule(schedule) do
    Cocktail.Schedule.add_recurrence_rule(
      Cocktail.Schedule.new(schedule.start_at || DateTime.utc_now()),
      String.to_atom(schedule.frequency),
      build_rule_opts(schedule)
    )
  end

  def build_rule_opts(schedule) do
    Enum.reduce(rule_opts(schedule), [], fn({key, value}, opts) ->
      case add_rule_opt(key, value) do
        :skip ->
          opts
        value ->
          [{key, value} | opts]
      end
    end)
  end

  def rule_opts(schedule) do
    [
      interval: schedule.interval,
      count: schedule.count,
      until: schedule.end_at,
      days: schedule.days,
      hours: schedule.hours,
      minutes: schedule.minutes,
      seconds: schedule.seconds,
      times: schedule.times
    ]
  end

  def add_rule_opt(_key, nil) do
    :skip
  end

  def add_rule_opt(:times, times) do
    Enum.map(times, fn(time_of_day) ->
      {:ok, time} = Time.new(time_of_day.hour, time_of_day.minute, 0)
      time
    end)
  end

  def add_rule_opt(:days, days) do
    Enum.map(days, &String.to_atom/1)
  end

  def add_rule_opt(_key, value) do
    value
  end
end
