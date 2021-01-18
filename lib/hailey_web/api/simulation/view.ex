defmodule HaileyWeb.Api.Simulation.View do
  use HaileyWeb, :view

  def render("create.json", _) do
    %{simulation: "created"}
  end

  def render("delete.json", _) do
    %{simulation: "deleted"}
  end
end
