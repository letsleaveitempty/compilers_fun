require_relative 'lexer'
require_relative 'parser'

describe Lexer do
  it 'lexes numbers' do
    expect(Lexer.new('3').token).to be_a(Token::Number)
    expect(Lexer.new('3').token.to_s).to eq('3')
  end

  it 'lexes +' do
    expect(Lexer.new('+').token).to be_a(Token::Plus)
    expect(Lexer.new('+').token.to_s).to eq('+')
  end

  it 'lexes *' do
    expect(Lexer.new('*').token).to be_a(Token::Asterisk)
    expect(Lexer.new('*').token.to_s).to eq('*')
  end

  it 'lexes parenthesis' do
    expect(Lexer.new('(').token).to be_a(Token::LParen)
    expect(Lexer.new(')').token).to be_a(Token::RParen)
  end

  it 'detects the end of the input' do
    lexer = Lexer.new('1')

    token = lexer.token
    expect(token).to be_a(Token::Number)

    token = lexer.next_token
    expect(token).to eq(nil)
  end

  it 'lexes multiple tokens in right order' do
    lexer = Lexer.new('1+2*3')

    token = lexer.token
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

    token = lexer.token
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

  it 'parses nested operations of two kinds' do
    expect(Parser.new('1 * 5 + 2').parse.to_s).to eq('(+ (* 1 5) 2)')
  end

  it 'parses nested operations with braces' do
    expect(Parser.new('1 * (5 + 2)').parse.to_s).to     eq('(* 1 (+ 5 2))')
    expect(Parser.new('4 * (5 + 2) + 3').parse.to_s).to eq('(+ (* 4 (+ 5 2)) 3)')
    expect(Parser.new('2 * (5 + 1) * 3').parse.to_s).to eq('(* (* 2 (+ 5 1)) 3)')
  end
end

describe 'AST node#execution' do
  it 'executes a parsed string' do
    expect(Parser.new('1 + 5 * 2').parse.execute).to       eq(11)
    expect(Parser.new('1 * 5 + 2').parse.execute).to       eq(7)
    expect(Parser.new('2 * (5 + 2)').parse.execute).to     eq(14)
    expect(Parser.new('4 * (5 + 2) + 3').parse.execute).to eq(31)
    expect(Parser.new('2 * (5 + 1) * 3').parse.execute).to eq(36)
  end
end
