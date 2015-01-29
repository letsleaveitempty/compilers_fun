# example:
#
# "1 +2"
#
# <number, "1"> <whitespace> <operator, "+"> <number, "2">

class Token
end

class Number < Token
  attr_reader :value

  def initialize(value)
    @value = value
  end

  def print_token
    print "<number,\"#{value}\">"
  end
end

class Whitespace < Token
  attr_reader :value

  def initialize(value)
    @value = value
  end

  def print_token
    print "<whitespace>"
  end
end

class Operator < Token
  attr_reader :value

  def initialize(value)
    @value = value
  end

  def print_token
    print "<operator,\"#{value}\">"
  end
end

def tokenize(string)
  elements = string.scan(/./)

  elements.map! { |el| assign_class(el) }
  elements.each { |el| el.print_token   }
end

def assign_class(string)
  case string
  when /\s/
    Whitespace.new(string)
  when /[+]/
    Operator.new(string)
  when /[0-9]*/
    Number.new(string)
  end
end


string = "1 +2"

puts string
tokenize(string)
