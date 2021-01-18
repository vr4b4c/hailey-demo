defmodule HaileyWeb.Api.Schedules.Controller do
  use HaileyWeb, :controller

  # POST /api/schedules
  def create(conn, %{"schedule" => params}) do
    case Hailey.Scheduling.Operation.create(params) do
      {:ok, schedule} ->
        Hailey.Scheduling.Operation.start_recurrence(schedule)
        render(conn, "show.json", %{schedule: schedule})
      {:error, reason} ->
        conn
        |> put_status(:bad_request)
        |> put_view(HaileyWeb.ErrorView)
        |> render("error.json", %{reason: reason})
    end
  end
end
