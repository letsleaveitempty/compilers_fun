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
