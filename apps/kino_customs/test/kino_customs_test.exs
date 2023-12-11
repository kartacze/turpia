defmodule KinoCustomsTest do
  use ExUnit.Case
  doctest KinoCustoms

  test "greets the world" do
    assert KinoCustoms.hello() == :world
  end
end
