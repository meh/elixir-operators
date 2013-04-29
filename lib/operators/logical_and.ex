#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.

defprotocol Operator.Logical.And do
  def a and b
end

Operators.define fn type ->
  defimpl Operator.Logical.And, for: type do
    def a and b do
      Kernel.and(a, b)
    end
  end
end
