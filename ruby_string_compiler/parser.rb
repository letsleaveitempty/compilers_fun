require_relative 'token_classes'
require_relative 'AST_classes'
require_relative 'lexer'

class Parser
  attr_accessor :lexer

  def initialize(input_string)
    self.lexer = Lexer.new(input_string)
  end

  def parse
    @token = lexer.token
    sum
  end

  def sum
    puts "lalalallal"
    puts @token.class
    case @token
    when Token::Number
      ast = AST::Number.new(@token.value)
    else
      raise "Expected a number (0-9)"
    end

    other_token = lexer.next_token
    case other_token
    when nil
      return ast
    when Token::Plus
      the_sum = sum
      return AST::Operand.new('+', [AST::Number.new(@token.value), the_sum])
    else
      raise "Expected a 'plus' operator (+)"
    end
    @token = other_token
  end

  # def check_token(token)
  #   case token
  #   when Token::Number
  #     @ast = AST::Number.new(token.value)
  #     @token = token
  #     check_next_token
  #   else
  #     raise "Expected a number (0-9)"
  #   end
  # end
  #
  # def check_next_token
  #   other_token = lexer.next_token
  #   case other_token
  #   when nil
  #     return @ast
  #   when Token::Plus
  #     the_sum = check_next_token
  #     return AST::Operand.new('+', [AST::Number.new(@token.value), the_sum])
  #   when Token::Asterisk
  #     the_product = check_next_token
  #     return AST::Operand.new('*', [AST::Number.new(@token.value), the_product])
  #   when Token::Number
  #     check_token(other_token)
  #   else
  #     raise "Operator not allowed"
  #   end
  # end
end
