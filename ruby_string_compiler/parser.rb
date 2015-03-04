require_relative 'token_classes'
require_relative 'AST_classes'
require_relative 'lexer'
require 'pry'

class Parser
  attr_accessor :lexer

  def initialize(input_string)
    self.lexer  = Lexer.new(input_string)
    @token      = lexer.token
    @next_token = lexer.next_token
  end

  def parse
    expression
  end

  def expression
    current_result = number

    while @next_token
      case @next_token
      when Token::Asterisk
        move_two_tokens_forward
        operand2 = number
        current_result= AST::Multiplication.new([current_result, operand2])
      when Token::Plus
        move_two_tokens_forward
        operand2 = expression
        current_result = AST::Addition.new([current_result, operand2])
      when Token::RParen
        break
      end
    end

    current_result
  end

  def number
    case @token
    when Token::LParen
      move_paren
      value = expression
      move_paren
    when Token::Number
      value = AST::Number.new(@token.value)
    else
      raise "Not a number."
    end

    value
  end

  private
    def move_paren
      @token = @next_token
      @next_token = lexer.next_token
    end

    def move_two_tokens_forward
      @token      = lexer.next_token
      @next_token = lexer.next_token
    end
end
