defmodule Hailey.Repo do
  use Ecto.Repo,
    otp_app: :hailey,
    adapter: Ecto.Adapters.Postgres
end
