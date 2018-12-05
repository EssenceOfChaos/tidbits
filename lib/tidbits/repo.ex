defmodule Tidbits.Repo do
  use Ecto.Repo,
    otp_app: :tidbits,
    adapter: Ecto.Adapters.Postgres
end
