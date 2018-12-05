defmodule Tidbits.Plug.EnsureAuthentication do
  @moduledoc false
  use Guardian.Plug.Pipeline,
    otp_app: :tidbits,
    module: Tidbits.Accounts.Guardian

  plug(Guardian.Plug.EnsureAuthenticated)
  plug Guardian.Plug.LoadResource, allow_blank: true

end
