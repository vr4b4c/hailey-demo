defmodule HaileyWeb.Api.Schedules.ControllerTest do
  use HaileyWeb.ConnCase

  describe "create" do
    test "succedes", %{conn: conn} do
      params = %{start_at: "2018-09-18 12:00:00", frequency: "daily"}

      conn
      |> post(Routes.schedule_path(conn, :create, %{schedule: params}))
      |> json_response(:ok)

      assert Hailey.Repo.aggregate(Hailey.Scheduling.Schedule, :count, :id) == 1
    end

    test "fails with invalid params", %{conn: conn} do
      params = %{start_at: "2018-09-18 12:00:00", frequency: "invalid-freq"}

      conn
      |> post(Routes.schedule_path(conn, :create, %{schedule: params}))
      |> json_response(:bad_request)

      assert Hailey.Repo.aggregate(Hailey.Scheduling.Schedule, :count, :id) == 0
    end
  end
end
