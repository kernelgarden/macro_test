defmodule Assertions do
  defmacro assert({:==, _, [lhs, rhs]} = expr) do
    quote do
      left_value = unquote(lhs)
      right_value = unquote(rhs)

      case left_value == right_value do
        true ->
          :ok
        false ->
          IO.puts("Assertion with == failed")
          #IO.puts("code: #{unquote(lhs)} == #{unquote(rhs)}")
          IO.puts("code: #{unquote(Macro.to_string(expr))}")
          IO.puts("lhs: #{left_value}")
          IO.puts("rhs: #{right_value}")
          :error
      end
    end
  end

  # generic version
  defmacro assert({operator, _, [lhs, rhs]} = expr)
      when operator in [:==, :<, :>, :<=, :>=, :===, :=~, :!==, :!=, :in] do
    quote do
      left_value = unquote(lhs)
      right_value = unquote(rhs)

      result = unquote(operator) (left_value, right_value)

      case result do
        true ->
          :ok
        false ->
          IO.puts("Assertion with #{unquote(operator)}")
          IO.puts("code: #{unquote(Macro.to_string(expr))}")
          IO.puts("lhs: #{left_value}")
          IO.puts("rhs: #{right_value}")
          :error
      end
    end
  end
end
