class Token
  Plus     = 0
  Minus    = 1
  Multiply = 2
  Divide   = 3

  Number   = 4

  LParen   = 5
  RParen   = 6

  End      = 7

  attr_accessor :kind
  attr_accessor :value

  def initialize
    @kind = nil
    @value = nil
  end

  def unknown?
    @kind.nil?
  end
end


class Lexer
  def initialize(input)
    @input = input
    @return_previous_token = false
  end

  def get_next_token
    if @return_previous_token
      @return_previous_token = false
      return @previous_token
    end

    token = Token.new

    @input.lstrip!

    case @input
      when /\A\+/ then
        token.kind = Token::Plus
      when /\A-/ then
        token.kind = Token::Minus
      when /\A\*/ then
        token.kind = Token::Multiply
      when /\A\// then
        token.kind = Token::Divide
      when /\A\d+(\.\d+)?/
        token.kind = Token::Number
        token.value = $&.to_f
      when /\A\(/
        token.kind = Token::LParen
      when /\A\)/
        token.kind = Token::RParen
      when ''
        token.kind = Token::End
    end

    raise 'Unknown token' if token.unknown?
    @input = $'

    @previous_token = token
    token
  end

  def revert
    @return_previous_token = true
  end
end
