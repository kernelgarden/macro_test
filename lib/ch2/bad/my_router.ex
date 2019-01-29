defmodule Bad.MyRouter do
  import Plug.Bad.Router

  def match(type, route) do
    do_match(type, route, :dummy_connection)
  end

  get "/hello", do: {conn, "Hi"}
  get "/goodby", do: {conn, "Bye"}

end
