# number ::= '0' | '1' | '2' | '3' | '4' | '5' | '6' | '7' | '8' | '9';
# sum    ::= number + sum | number;
# next to do: multiplication
#
# number ::= '0' | '1' | '2' | '3' | '4' | '5' | '6' | '7' | '8' | '9';
# expression

class Token
end

class AST
end

class Token::Number
  attr_reader :value

  def initialize(value)
    @value = value
  end

  def to_s
    value
  end

  def print_token
    print "<number,\"#{value}\">"
  end
end

class Token::Plus
  attr_reader :value

  def initialize(value)
    @value = value
  end

  def to_s
    value
  end

  def print_token
    print "<operator,\"#{value}\">"
  end
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

class Lexer
  attr_reader :input_string

  def initialize(input_string)
    @input_string = input_string
    get_elements(input_string)
  end

  def get_elements(input_string)
    elements = input_string.scan(/./)

    elements.map! { |el| assign_class(el) }
    elements.compact!
    @elements = elements
  end

  def assign_class(string)
    case string
    when /\s/
      nil # not caring about whitespaces for now
    when /[+]/
      Token::Plus.new(string)
    when /[0-9]*/
      Token::Number.new(string)
    end
  end

  def next_token
    @elements.delete_at(0)
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

describe Lexer do
  it 'lexes numbers' do
    expect(Lexer.new('3').next_token).to be_a(Token::Number)
    expect(Lexer.new('3').next_token.to_s).to eq('3')
  end

  it 'lexes +' do
    expect(Lexer.new('+').next_token).to be_a(Token::Plus)
    expect(Lexer.new('+').next_token.to_s).to eq('+')
  end

  it 'lexes *' do
    expect(Lexer.new('*').next_token).to be_a(Token::Asterisk)
    expect(Lexer.new('*').next_token.to_s).to eq('*')
  end

  it 'detects the end of the input' do
    lexer = Lexer.new('1')

    token = lexer.next_token
    expect(token).to be_a(Token::Number)

    token = lexer.next_token
    expect(token).to eq(nil)
  end

  it 'lexes multiple tokens in right order' do
    lexer = Lexer.new('1+2*3')

    token = lexer.next_token
    expect(token).to be_a(Token::Number)
    expect(token.to_s).to eq('1')

    token = lexer.next_token
    expect(token).to be_a(Token::Plus)
    expect(token.to_s).to eq('+')

    token = lexer.next_token
    expect(token).to be_a(Token::Number)
    expect(token.to_s).to eq('2')

    token = lexer.next_token
    expect(token).to be_a(Token::Asterisk)
    expect(token.to_s).to eq('*')

    token = lexer.next_token
    expect(token).to be_a(Token::Number)
    expect(token.to_s).to eq('3')

    token = lexer.next_token
    expect(token).to eq(nil)
  end

  it 'ignores whitespace' do
    lexer = Lexer.new(' 1')

    token = lexer.next_token
    expect(token).to be_a(Token::Number)
    expect(token.to_s).to eq('1')
  end
end

describe Parser do
  it 'parses numbers' do
    expect(Parser.new('3').parse.to_s).to eq('3')
  end

  it 'parses simple sums' do
    expect(Parser.new('3 + 5').parse.to_s).to eq('(+ 3 5)')
  end

  it 'parses simple multiplication' do
    expect(Parser.new('3 * 5').parse.to_s).to eq('(* 3 5)')
  end

  it 'parses nested sums' do
    expect(Parser.new('3 + 5 + 7').parse.to_s).to eq('(+ 3 (+ 5 7))')
  end

  it 'parses nested operations of two kinds' do
    expect(Parser.new('1 + 5 * 2').parse.to_s).to eq('(+ 1 (* 5 2))')
  end

  it 'parses nested operations and distinguish multiplication' do
    expect(Parser.new('1 * 5 + 2').parse.to_s).to eq('(+ 2 (* 1 5))')
  end
end

describe 'AST node#execution' do
  it 'executes a parsed string' do
    expect(Parser.new('1 + 5 * 2').parse.execute).to eq(11)
    expect(Parser.new('1 * 5 + 2').parse.execute).to eq(7)
  end
end
