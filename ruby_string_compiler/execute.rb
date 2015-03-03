require_relative 'parser'

loop do
  puts "\n*************************************\n"
  puts "Enter your math operation:"
  string = gets
  lexer  = Lexer.new(string)

  puts "\nTokens and its values:"
  lexer.print_tokens

  puts "\nAST classes representation:"
  puts Parser.new(string).parse.inspect

  puts "\nAST string representation:"
  puts Parser.new(string).parse

  puts "\nExecution (result):"
  puts Parser.new(string).parse.execute
end
