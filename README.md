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
  defoperator :+ do
    Operators.+(self.value, other)
  end
end

Derp.new(value: 40) + 2 # => 42
```
