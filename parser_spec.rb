# Run with: rspec parser_spec.rb

class Lexer
  def initialize(input_string)
  end

  def next_token
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

  it 'detects the end of the input' do
    lexer = Lexer.new('1')

    token = lexer.next_token
    expect(token).to be_a(Token::Number)

    token = lexer.next_token
    expect(token).to eq(nil)
  end

  it 'lexes multiple tokens' do
    lexer = Lexer.new('1+2')

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
    expect(token).to eq(nil)
  end

  it 'ignores whitespace' do
    lexer = Lexer.new(' 1')

    token = lexer.next_token
    expect(token).to be_a(Token::Number)
    expect(token.to_s).to eq('1')
  end
end

class Parser
  def initialize(input_string)
  end

  def parse
  end
end

describe Parser do
  it 'parses numbers' do
    expect(Parser.new('3').parse.to_s).to eq('3')
  end

  it 'parses simple sums' do
    expect(Parser.new('3 + 5').parse.to_s).to eq('(+ 3 5)')
  end

  it 'parses nested sums' do
    expect(Parser.new('3 + 5 + 7').parse.to_s).to eq('(+ 3 (+ 5 7))')
  end
end

