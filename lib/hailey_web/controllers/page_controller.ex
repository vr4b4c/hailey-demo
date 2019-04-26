defmodule HaileyWeb.PageController do
  use HaileyWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
