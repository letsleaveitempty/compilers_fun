
sum ::= number | number '+' sum;
number ::= '0'...'9';




class Token::Number
  def value
  end
end

class Token::Plus
end

class AST::Number
end

class AST::Operand
end

class Lexer
  def initialize(input_string)
  end

  def next_token
  end
end

class Parser
  attr_accessor :lexer

  def initialize(input_string)
    self.lexer = Lexer.new(input_string)
  end

  def parse
    sum
  end

  def sum
    token = lexer.next_token

    case token
    when Token::Number
      ast = AST::Number.new(token.value)
    else
      raise "Expected a number"
    end

    other_token = lexer.next_token
    if other_token.nil?
      return ast
    end

    if !other_token.kind_of? Token::Plus
      raise "Expected a +"
    end

    the_sum = sum
    return AST::Operand.new('+', [AST::Number.new(token.value), the_sum])
  end
end







