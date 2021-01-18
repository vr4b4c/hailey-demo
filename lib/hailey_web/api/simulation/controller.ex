defmodule HaileyWeb.Api.Simulation.Controller do
  use HaileyWeb, :controller

  # POST /api/simulation
  def create(conn, params) do
    Hailey.Simulation.start(params)

    render(conn, "create.json", %{})
  end

  # POST /api/simulation
  def delete(conn, _params) do
    Hailey.Simulation.stop()

    render(conn, "delete.json", %{})
  end
end
