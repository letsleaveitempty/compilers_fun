require_relative 'token_classes'
require_relative 'AST_classes'
require_relative 'lexer'

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
      raise "Expected a number (0-9)"
    end

    other_token = lexer.next_token
    case other_token
    when nil
      return ast
    when Token::Plus
      the_sum = sum
      return AST::Operand.new('+', [AST::Number.new(token.value), the_sum])
    else
      raise "Expected a 'plus' operator (+)"
    end
  end
end
