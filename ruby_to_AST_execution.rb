# number     ::= '0' | '1' | '2' | '3' | '4' | '5' | '6' | '7' | '8' | '9';
# expression ::= number + expression | number;


other_token = lexer.next_token

case other_token
when nil
  return ast
when Token::Plus
  the_sum = sum
  retrun AST::Operand....
else
  raise "error"
end



class Lexer
  def initialize(string)
  end

  def next_token

  end
end

class Parser
  attr_reader :lexer

  def initialize(string)
    self.lexer = Lexer.new(string)
  end

  def parse
    token = lexer.next_token

    case token
    when Number
      return Number
    when Plus
      Number + token
    else
      raise "errrrrorrrrr"
    end
    # return ast
  end
end




#####################################
### tokenizer #######################
#####################################

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
  elements.compact!
  elements.each { |el| el.print_token   }
end

def assign_class(string)
  case string
  when /\s/
    nil # not caring about whitespaces for now
  when /[+]/
    Operator.new(string)
  when /[0-9]*/
    Number.new(string)
  end
end

#####################################
### compilation engine ##############
#####################################

# number     ::= '0' | '1' | '2' | '3' | '4' | '5' | '6' | '7' | '8' | '9';
# expression ::= number + expression | number;

class AstTree
end

class AstNumber < AstTree
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

class AstOperator < AstTree
  attr_reader :operator, :operands

  def initialize(operator, operands)
    @operator = operator
    @operands = operands
  end

  def string_representation
    puts operator
    puts operands
  end

  def execute
    operands[0].execute + operands[1].execute
  end
end

def tokens_to_ast(tokens)
  tokens.map! { |t| assign_ast_class(t) }
  end
end

def assign_ast_class(token)
  case token.class
  when Number
    AstNumber.new(token.value)
  when Operator
    AstOperator.new(token.value)
  end
end



#####################################
### execution #######################
#####################################

def string_to_exec(string)
  puts string
  puts "\n\n"
  tokens = tokenize(string)
  puts "\n\n"
  puts tokens
  puts "\n\n"
  puts tokens_to_ast(tokens)
  puts "\n\n"
end

# 1 + 2
# ast = AstOperator.new("+", [AstNumber.new("1"), AstNumber.new("2")])
# 1 + (2 + 7)
# ast = AstOperator.new("+", [AstNumber.new("1"), AstOperator.new("+", [AstNumber.new("2"), AstNumber.new("7")])])
# puts ast.string_representation
# puts ast.execute


string = "3+  2"

string_to_exec(string)
