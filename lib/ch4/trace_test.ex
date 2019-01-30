defmodule TraceTest do
  import Trace

  deftracable my_fun(a, b) do
    a / b
  end

  deftracable my_fun(a, b, c, d, e, f) do
    a + b + c + d + e + f
  end

  deftracable fun1(a, b) when a > b do
    a / b
  end
end
