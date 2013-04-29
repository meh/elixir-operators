#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.

defprotocol Operator.Logical.Xor do
  def a xor b
end

Operators.define fn type ->
  defimpl Operator.Logical.Xor, for: type do
    def a xor b do
      Kernel.xor(a, b)
    end
  end
end
