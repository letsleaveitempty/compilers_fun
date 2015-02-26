require_relative 'token_classes'
require_relative 'AST_classes'
require_relative 'lexer'

class Parser
  attr_accessor :lexer

  def initialize(input_string)
    self.lexer  = Lexer.new(input_string)
    @token      = lexer.token
    @next_token = lexer.next_token
  end

  def parse
    # expression
    if @next_token.nil?
      number
    else
      expression
    end
  end

  def expression
    operand1 = number

    case @next_token
    when Token::Asterisk
      move_one_token_forward
      operand2 = number
      result   = AST::Multiplication.new([operand1, operand2])
    when Token::Plus
      move_one_token_forward
      operand2 = expression
      result   = AST::Addition.new([operand1, operand2])
    when nil
      result   = operand1
    end

    result
  end

  def number
    case @token
    when Token::Number
      value = AST::Number.new(@token.value)
    else
      raise "Not a number."
    end

    value
  end

  def move_one_token_forward
    @token      = lexer.next_token
    @next_token = lexer.next_token
  end
end
