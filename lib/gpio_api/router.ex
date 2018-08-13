defmodule GpioApi.Router do
  use Plug.Router
  use Plug.Debugger
  require Logger

  plug Plug.Parsers, parsers: [:urlencoded]
  plug(Plug.Logger, log: :debug)

  plug(:match)
  plug(:dispatch)

  put "/garage/toggle" do
    GpioApi.Garage.toggle(conn)
  end

  match _ do
    send_resp(conn, 404, "not found")
  end
end
