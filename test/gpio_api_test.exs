defmodule GpioApiTest do
  use ExUnit.Case
  doctest GpioApi

  test "greets the world" do
    assert GpioApi.hello() == :world
  end
end
