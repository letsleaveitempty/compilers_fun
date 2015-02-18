require_relative 'token_classes.rb'

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
    @position = 0
  end

  def assign_class(element)
    case element
    when /\s/
      nil
    when /[+]/
      Token::Plus.new(element)
    when /[*]/
      Token::Asterisk.new(element)
    when /[0-9]*/
      Token::Number.new(element)
    end
  end

  def token
    @elements[@position]
  end

  def next_token
    @position += 1
    token
  end

  def print_tokens
    @elements.each { |el| puts "#{el.class}, #{el.value}" }
  end
end
