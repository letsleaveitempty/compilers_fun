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
    expression
  end

  def expression
    current_result = number

    while @next_token
      case @next_token
      when Token::Asterisk
        move_one_token_forward
        operand2 = number
        current_result= AST::Multiplication.new([current_result, operand2])
      when Token::Plus
        move_one_token_forward
        operand2 = expression
        current_result = AST::Addition.new([current_result, operand2])
      end
    end

    current_result
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
# 
# puts "Enter expression:\n"
# p = Parser.new(gets)
# puts p.parse
