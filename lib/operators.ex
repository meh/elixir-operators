#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.

defmodule Operators do
  @list [
    +: Operator.Add,
    -: Operator.Subtract,
    *: Operator.Multiply,
    /: Operator.Divide,

    ++: Operator.Append,
    --: Operator.Difference,
    <>: Operator.Concat,

    <-: Operator.Send,

    !: Operator.Not,

    ==: Operator.Equal,
    !=: Operator.Unequal,
    <:  Operator.Lesser,
    >:  Operator.Greater,
    <=: Operator.LesserOrEqual,
    >=: Operator.GreaterOrEqual,
    =~: Operator.Match,

    ===: Operator.Strict.Equal,
    !==: Operator.Strict.Unequal,

    &&: Operator.And,
    ||: Operator.Or,

    and: Operator.Logical.And,
    or:  Operator.Logical.Or,
    xor: Operator.Logical.Xor
  ]

  def define(for // [Record, Tuple, Atom, List, BitString, Number, Function, PID, Port, Reference], fun) do
    Enum.each for, fun
  end

  def for(name) do
    @list[name]
  end

  @doc false
  defmacro __using__(opts) do
    chosen = cond do
      opts[:only] ->
        Enum.map opts[:only], fn name ->
          { name, if name in [:!, :@], do: 1, else: 2 }
        end

      opts[:except] ->
        Enum.filter_map @list, fn { name, _ } ->
          not List.member?(opts[:except], name)
        end, fn { name, _ } ->
          { name, if name in [:!, :@], do: 1, else: 2 }
        end

      true ->
        Enum.map @list, fn { name, _ } ->
          { name, if name in [:!, :@], do: 1, else: 2 }
        end
    end

    chosen = [{ :defoperator, 2 } | chosen]

    quote do
      import Kernel, except: unquote(chosen)
      import Operators, only: unquote(chosen)
    end
  end

  defmacro defoperator({ name, _, [_, _] = args }, do: body) when not (name in [:!, :@]) do
    mod  = Operators.for(name)
    args = Macro.escape(args)
    body = Macro.escape(body)

    quote do
      args = unquote(args)
      body = unquote(body)

      defimpl unquote(mod), for: __MODULE__ do
        def unquote(name), args, [], do: body
      end
    end
  end

  defmacro defoperator({ name, _, [_] = args }, do: body) when name in [:!, :@] do
    mod  = Operators.for(name)
    args = Macro.escape(args)
    body = Macro.escape(body)

    quote do
      args = unquote(args)
      body = unquote(body)

      defimpl unquote(mod), for: __MODULE__ do
        def unquote(name), args, [], do: body
      end
    end
  end

  Enum.each @list, fn { name, module } ->
    if name in [:!, :@] do
      def name, quote(do: [a]), [] do
        quote do
          unquote(module).unquote(name)(a)
        end
      end
    else
      def name, quote(do: [a, b]), [] do
        quote do
          unquote(module).unquote(name)(a, b)
        end
      end
    end
  end
end
