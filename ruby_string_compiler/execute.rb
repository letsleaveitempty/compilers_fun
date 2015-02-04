require_relative 'parser'


string = "1 * 2 +3 "

puts "\nString:"
puts string
puts "\nTokens and its values:"
Lexer.new(string).print_tokens
puts "\nAST representation:"
puts Parser.new(string).parse
# puts "\nAST execution:"
# puts Parser.new(string).parse.execute
