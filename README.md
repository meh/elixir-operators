Operator "overloading" in Elixir
================================
This toy library implements operators as protocols, so you can extend them for
anything.

Pretty jolly, isn't it?

Examples
--------

```elixir
use Operators

defrecord Derp, value: 23 do
  defoperator a + b do
    Operators.+(a.value, b)
  end
end

Derp.new(value: 40) + 2 # => 42
```
