# addition:
#   1 + 2
#   1 + 2 + 3
#
# substraction:
#   2 - 1
#   5 - 2 - 1
#
# multiplication:
#   1 * 2
#   2 * 3 * 4
#   4!
#
# division:
#   2 / 1
#   12 / 3 / 2
#
# if statements:
#   if true
#     ....
#   else
#     ....
#   end


class AstTree
end

class Number < AstTree
  attr_reader :value

  def initialize(value)
    @value = value
  end

  def to_s
    value
  end
end

class Operator < AstTree
  attr_reader :operator, :operands

  def initialize(operator, operands)
    @operator = operator
    @opernads = operands
  end

  def to_s

  end
end
