require_relative 'parser'


string = "1 + 3"

puts "\nString:"
puts string
puts "\nAST representation:"
puts Parser.new(string).parse
puts "\nAST execution:"
puts Parser.new(string).parse.execute
