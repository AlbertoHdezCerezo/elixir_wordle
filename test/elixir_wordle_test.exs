defmodule ElixirWordleTest do
  use ExUnit.Case
  doctest ElixirWordle

  test "greets the world" do
    assert ElixirWordle.hello() == :world
  end
end
