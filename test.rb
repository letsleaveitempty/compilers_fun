class Lexer

  def initialize
    @things = [1,2,3,4,5]
    @position = 0
  end

  def token
    @things[@position]
  end

  def next_token
    @position += 1
    token
  end
end

a = Lexer.new()

puts a.token
puts a.token
puts a.next_token
puts a.token
puts a.next_token
puts a.next_token
