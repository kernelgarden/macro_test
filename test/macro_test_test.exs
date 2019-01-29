defmodule MacroTestTest do
  use ExUnit.Case
  doctest MacroTest

  test "greets the world" do
    assert MacroTest.hello() == :world
  end
end
