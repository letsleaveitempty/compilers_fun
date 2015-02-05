require_relative 'parser'

string = File.read(ARGV[0])

puts "\nString:"
puts string

puts "\nTokens and its values:"
Lexer.new(string).print_tokens

puts "\nAST classes representation:"
puts Parser.new(string).parse.inspect

puts "\nAST string representation:"
puts Parser.new(string).parse

puts "\nExecution (result):"
puts Parser.new(string).parse.execute
