defmodule Tracer do
  defmacro trace(expr) do
    represent_string = Macro.to_string(expr)

    quote do
      result = unquote(expr)
      # expr이 1 + 2 라는 식일 때, represent_string은 "1 + 2"다.(AST fragment 상태)
      # 따라서 현재 문맥이 quote이기 때문에 unquote로 다시 넘겨서 풀어주어야한다. (code fragment로)
      # (quote는 code fragment를 취해서 ast fragment로 바꿔준다.)
      Tracer.print(unquote(represent_string), result)
    end
  end

  def print(represent_string, value) do
    IO.puts("Result of #{represent_string} = #{value}")
  end
end
