defmodule Plug.Bad.Router do
  defmacro get(router, body) do
    quote do
      defp do_match("GET", unquote(router), var!(conn)) do
        unquote(body[:do])
      end
    end
  end

end
