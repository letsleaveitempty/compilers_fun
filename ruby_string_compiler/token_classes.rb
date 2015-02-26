class Token
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
    print "<operator, +>"
  end
end

class Token::Asterisk
  attr_reader :value

  def initialize(value)
    @value = value
  end

  def to_s
    value
  end

  def print_token
    print "<operator, *>"
  end
end

class Token::LParen
  attr_reader :value

  def initialize(value)
    @value = value
  end

  def to_s
    value
  end

  def print_token
    print "<LParen, (>"
  end
end

class Token::RParen
  attr_reader :value

  def initialize(value)
    @value = value
  end

  def to_s
    value
  end

  def print_token
    print "<RParen, )>"
  end
end
