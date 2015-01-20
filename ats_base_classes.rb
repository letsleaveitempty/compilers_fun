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
#
# factorial:
#   4!
#
# division:
#   2 / 1
#   12 / 3 / 2
#
# parethesis:
#   2 * ( 5 - 7 )
#   (2 *  5) - 7
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

  def execute
    value.to_i
  end
end

class Operator < AstTree
  attr_reader :operator, :operands

  def initialize(operator, operands)
    @operator = operator
    @operands = operands
  end

  def execute
    operands[0].execute + operands[1].execute
  end
end

# 1 + 2
# ast = Operator.new("+", [Number.new("1"), Number.new("2")])

# (3 + 2) + 5
 # ast = Operator.new("+", [Operator.new("+", [Number.new("3"), Number.new("2")]), Number.new("5")])

# 1 + (2 + 7)
# ast = Operator.new("+", [Number.new("1"), Operator.new("+", [Number.new("2"), Number.new("7")])])

# (((1 + (3 + 2)) + 5) + 2) + 5 + (2 + (1+2))
ast = Operator.new("+", [Operator.new("+", [Operator.new("+", [Operator.new("+", [Number.new("1"), Operator.new("+", [Operator.new("+", [Number.new("3"), Number.new("2")]), Number.new("5")])]), Number.new("2")]), Number.new("5")]), Operator.new("+", [Number.new("2"), Operator.new("+", [Number.new("1"), Number.new("2")])])])

puts ast.execute
