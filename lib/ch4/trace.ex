defmodule Trace do

  # head => {:func, [context: Elixir], [{:a, [], Elixir}, {:b, [], Elixir}]}
  # body =>
  # [
  #   do: {:/, [context: Elixir, import: Kernel],
  #     [{:a, [], Elixir}, {:b, [], Elixir}]}
  # ]
  @doc """
  - The macro doesn’t handle guards well
  - Pattern matching arguments will not always work (e.g. when using _ to match any term)
  - The macro doesn’t work when dynamically generating code directly in the module.
  """
  defmacro deftracable(head, body) do
    # Macro.decompose_call(ast) 를 통해 함수명과 함수 인자들을 추출한다.
    {func_name, args} = name_and_args(head)

    quote do
      def unquote(head) do
        file = __ENV__.file
        line = __ENV__.line
        module = __ENV__.module

        # args가 code fragment로 풀리면 [a, b...] 이런식으로 리스트로 나온다.
        # inspect로 문자열로 한번 정제 후 join을 한다.
        passed_args =
          unquote(args)
          |> Enum.map(&inspect/1)
          |> Enum.join(", ")

        result = unquote(body[:do])

        loc = "#{file}(line #{line})"
        cal = "#{module}.#{unquote(func_name)}(#{passed_args}) = #{result}"
        IO.puts("# => #{loc} #{cal}")

        result
      end
    end
  end

  # For gurad case
  # {:when, [],
  #   [
  #     {:my_fun, [], [{:a, [], Elixir}, {:b, [], Elixir}]},
  #     {:<, [context: Elixir, import: Kernel], [{:a, [], Elixir}, {:b, [], Elixir}]}
  #   ]
  # }
  defp name_and_args({:when, _, [head_ast | _]}) do
    name_and_args(head_ast)
  end

  defp name_and_args(head_ast) do
    Macro.decompose_call(head_ast)
  end
end
