defmodule Better.MyRouter do
  use Plug.Better.Router

  get "/hello", do: {conn, "hi"}
  get "/goodbye", do: {conn, "bye"}

  default do: {conn, :not_matched_error}
end
