Code.require_file "../test_helper.exs", __FILE__

defmodule OperatorsTest do
  use ExUnit.Case
  use Operators

  defrecord Derp, value: 23 do
    defoperator a + b do
      Operators.+(a.value, b)
    end
  end

  test "defoperator works" do
    assert Derp[value: 40] + 2 == 42
  end
end
