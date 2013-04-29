#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.

defprotocol Operator.Send do
  def a <- b
end

defimpl Operator.Send, for: PID do
  def a <- b do
    Kernel.<-(a, b)
  end
end

defimpl Operator.Send, for: Port do
  def a <- b do
    Kernel.<-(a, b)
  end
end
