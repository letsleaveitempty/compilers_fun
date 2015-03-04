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

  def assembly(assembler)
    register = assembler.next_register
    assembler.add_instructions("li $t#{register} #{@value}")
    "$t#{register}"
  end
end

class AST::Addition
  attr_reader :operands

  def initialize(operands)
    @operands = operands
  end

  def to_s
    "(+ #{operands[0]} #{operands[1]})"
  end

  def execute
    operands[0].execute + operands[1].execute
  end

  def assembly(assembler)
    register = assembler.next_register
    assembler.add_instructions("add $t#{register} #{operands[0].assembly(assembler)} #{operands[1].assembly(assembler)}")
    "$t#{register}"
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
    operands[0].execute * operands[1].execute
  end

  def assembly(assembler)
    register = assembler.next_register
    assembler.add_instructions("mul $t#{register} #{operands[0].assembly(assembler)} #{operands[1].assembly(assembler)}")
    "$t#{register}"
  end
end

class AST::LParen
  attr_reader :value

  def initialize(value)
    @value = value
  end
end

class AST::RParen
  attr_reader :value

  def initialize(value)
    @value = value
  end
end
