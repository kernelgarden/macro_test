defmodule Plug.Better.Router do
  # 모듈의 클라이언트가 세부 구현을 몰라도 사용 가능한 api를 노출 가능하다.
  defmacro __using__(_opts) do
    quote do
      import Plug.Better.Router

      def match(type, route) do
        do_match(type, route, :dummy_connection)
      end
    end
  end

  defmacro get(route, body) do
    quote do
      defp do_match("GET", unquote(route), var!(conn)) do
        unquote(body[:do])
      end
    end
  end

  defmacro default(body) do
    quote do
      defp do_match(_, _, var!(conn)) do
        unquote(body[:do])
      end
    end
  end
end
