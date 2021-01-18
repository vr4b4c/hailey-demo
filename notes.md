Enum.each(1..100, fn(i) ->
 if rem(i, 2) == 0 do
   Hailey.Scheduling.Schedule.changeset(%Hailey.Scheduling.Schedule{}, %{"sequence": i, "start_at": "2019-04-24 11:33:00", "frequency": "secondly", "interval": 2}) |> Hailey.Repo.insert
  else
  Hailey.Scheduling.Schedule.changeset(%Hailey.Scheduling.Schedule{}, %{"sequence": i, "start_at": "2019-04-24 11:34:01", "frequency": "secondly", "interval": 2}) |> Hailey.Repo.insert
  end
end)


curl -v localhost:4000/api/schedules -H "Content-Type: application/json" -X POST -d '{"schedule": {"start_at": "2019-04-24 11:33:00", "frequency": "secondly", "interval": 5}}'

Array.from(r.store().entries()).map((kvp) => kvp[1]).reduce((count, values) => values.indexOf('160ab664-a978-4581-968c-64def13f81c3') >= 0 ? count + 1 : count, 0)

Array.from(r.store().entries()).map((kvp) => kvp[1]).reduce((count, values) => values.indexOf('a789ed5c-879c-4894-a030-d94e08a096de') >= 0 ? count + 1 : count, 0)

var el = document.querySelector(".box[data-schedule-id='04c508d9-7e71-4da4-941b-cf436ed8c1af']");
```
