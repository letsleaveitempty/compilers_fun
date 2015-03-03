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
    create_assembly_file
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
        add_instructions("multiplication, #{current_result}, #{operand2} \n")
      when Token::Plus
        move_two_tokens_forward
        operand2 = expression
        current_result = AST::Addition.new([current_result, operand2])
        add_instructions("addition, #{current_result}, #{operand2} \n")
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
      add_instructions("li $t0 #{@token.value}\n")
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

    def create_assembly_file
      File.open("instructions.asm", 'w') {|f| f.write(".text\n\n.globl main\n\n\tmain:\n") }
    end

    def add_instructions(text)
      File.open("instructions.asm", 'a') {|f| f.write(text) }
    end

    def close_assembly_file
      File.open("instructions.asm", 'a') {|f| f.write("\tli $v0,10\n\tsyscall") }
    end
end
