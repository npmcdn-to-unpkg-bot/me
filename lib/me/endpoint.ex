defmodule Me.Endpoint do
  use Phoenix.Endpoint, otp_app: :me

  socket "/socket", Me.UserSocket

  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phoenix.digest
  # when deploying your static files in production.
  if System.get_env("MIX_ENV") == "prod" do
    plug Plug.Static,
      at: "/", from: :me, gzip: true,
      only: ~w(css fonts images js favicon.ico robots.txt .well-known)
  else
    plug Plug.Static,
      at: "/", from: :me, gzip: false,
      only: ~w(css fonts images js favicon.ico robots.txt .well-known)
  end

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    socket "/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
  end

  plug Plug.RequestId
  plug Plug.Logger

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head

  plug Plug.Session,
    store: :cookie,
    key: "_me_key",
    signing_salt: "PKwMuD1T"

  plug Me.Router
end
