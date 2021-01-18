defmodule HaileyWeb.Router do
  use HaileyWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", HaileyWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/api", HaileyWeb.Api do
    pipe_through :api

    resources "/schedules", Schedules.Controller, as: :schedule, only: [:create]
    resources "/simulation", Simulation.Controller, as: :simulation,
                                                    singleton: true,
                                                    only: [:create, :delete]
  end
end
