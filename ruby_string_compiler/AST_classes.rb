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

class AST::Operand
  attr_reader :operator, :operands

  def initialize(operator, operands)
    @operator = operator
    @operands = operands
  end

  def to_s
    "(#{operator} #{operands[0]} #{operands[1]})"
  end

  def execute
    operands[0].execute + operands[1].execute
  end
end
