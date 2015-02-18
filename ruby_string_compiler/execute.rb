require_relative 'parser'

string = File.read(ARGV[0])

lexer = Lexer.new(string)

puts "\nString:"
puts string

puts "\nTokens and its values:"
lexer.print_tokens

puts "\nTokens and next tokens:"
puts lexer.token
puts lexer.next_token
puts lexer.next_token
puts lexer.next_token

puts "\nAST classes representation:"
puts Parser.new(string).parse.inspect

puts "\nAST string representation:"
puts Parser.new(string).parse

puts "\nExecution (result):"
puts Parser.new(string).parse.execute
