require_relative 'lexer'

class Parser
  def parse(input)
    @lexer = Lexer.new(input)

    expression_value = expression

    token = @lexer.get_next_token
    if token.kind == Token::End
      expression_value
    else
      raise 'End expected'
    end
  end

  protected
  def expression
    component1 = factor

    additive_operators = [Token::Plus, Token::Minus]

    token = @lexer.get_next_token
    while additive_operators.include?(token.kind)
      component2 = factor

      if token.kind == Token::Plus
        component1 += component2
      else
        component1 -= component2
      end

      token = @lexer.get_next_token
    end
    @lexer.revert

    component1
  end

  def factor
    factor1 = number

    multiplicative_operators = [Token::Multiply, Token::Divide]

    token = @lexer.get_next_token
    while multiplicative_operators.include?(token.kind)
      factor2 = number

      if token.kind == Token::Multiply
        factor1 *= factor2
      else
        factor1 /= factor2
      end

      token = @lexer.get_next_token
    end
    @lexer.revert

    factor1
  end

  def number
    token = @lexer.get_next_token

    if token.kind == Token::LParen
      value = expression

      expected_rparen = @lexer.get_next_token
      raise 'Unbalanced parenthesis' unless expected_rparen.kind == Token::RParen
    elsif token.kind == Token::Number
      value = token.value
    else
      raise 'Not a number'
    end

    value
  end
end
