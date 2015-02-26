class AST
end

class AST::Number
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

# class AST::Operator
#
#   attr_reader :operands
#
#   def initialize(operands)
#     @operands = operands
#   end
#
#   def to_s
#     "(#{self.operator} #{operands[0]} #{operands[1]})"
#   end
# end
#
# class AST::Addition < AST::Operator
#   operator = "+"
#
#   def execute
#     operands[0].execute + operands[1].execute
#   end
# end
#
# class AST::Multiplication < AST::Operator
#
#   operator = "*"
#
#   def execute
#     operands[0].execute * operands[1].execute
#   end
# end

class AST::Addition
  attr_reader :operands

  def initialize(operands)
    @operands = operands
  end

  def to_s
    "(+ #{operands[0]} #{operands[1]})"
  end

  def execute
    operands[0] + operands[1]
  end
end

class AST::Multiplication
  attr_reader :operands

  def initialize(operands)
    @operands = operands
  end

  def to_s
    "(* #{operands[0]} #{operands[1]})"
  end

  def execute
    operands[0] * operands[1]
  end
end

# a = AST::Multiplication.new([2, 4])
# puts a
# puts a.class
# puts a.to_s
# puts a.execute
