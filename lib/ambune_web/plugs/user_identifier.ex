defmodule AmbuneWeb.Plug.UserIdentifier do
  import Plug.Conn

  def create_user_identifier(conn, _opts) do
    case get_session(conn, :user_uuid) do
      nil ->
        put_session(conn, :user_uuid, Ecto.UUID.generate())
      _ ->
        conn
    end
  end
end
