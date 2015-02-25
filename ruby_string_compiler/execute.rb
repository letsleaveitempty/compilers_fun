require_relative 'parser'

# string = File.read(ARGV[0])
puts "Enter your math operation:"
string = gets

lexer = Lexer.new(string)

puts "\n*************************************\n"
puts "\nMath operation:"
puts string

puts "\nTokens and its values:"
lexer.print_tokens

puts "\nTokens and next tokens:"
puts lexer.token.class
puts lexer.next_token.class
puts lexer.token.class
puts lexer.next_token.class
puts lexer.token.class
puts lexer.next_token.class
puts lexer.token.class

puts "\nAST classes representation:"
puts Parser.new(string).parse.inspect

# puts "\nAST string representation:"
# puts Parser.new(string).parse
#
# puts "\nExecution (result):"
# puts Parser.new(string).parse.execute
