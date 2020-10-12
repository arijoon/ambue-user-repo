defmodule Ambune.Repo do
  use Ecto.Repo,
    otp_app: :ambune,
    adapter: Ecto.Adapters.Postgres
end
