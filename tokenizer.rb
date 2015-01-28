# example:
#
# "1 +2"
#
# <number, "1"> <whitespace> <symbol, "+"> <number, "2">

string = "1 +2"

class Token
  def get_pieces(string)
    string.scan()
  end
end

class Number < Token
  def print_token(value)
    "< number, \"#{value}\">"
  end
end

class Whitespace < Token
  def print_token
  end
end

class Symbol < Token
  def print_token
  end
end
