defmodule Tidbits.Plug.Authentication do
  @moduledoc false
  use Guardian.Plug.Pipeline,
    otp_app: :tidbits,
    error_handler: Tidbits.GuardianErrorHandler,
    module: Tidbits.Accounts.Guardian

    plug Guardian.Plug.VerifySession, claims: %{"typ" => "access"}
    # plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}
    # plug Guardian.Plug.EnsureAuthenticated
    plug Guardian.Plug.LoadResource, allow_blank: true


end
