require_relative 'parser'
require_relative 'assembler'

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

  assembler = Assembler.new()
  register  = Parser.new(string).parse.assembly(assembler)

  File.open("instructions.asm", 'w') do |f|
    f.write(".text\n\n.globl main\n\n\tmain:\n\t")
    f.write(assembler.instructions.join("\n\t"))
    f.write("\n\n\tmove $a0 #{register}\n\tli $v0,1\n\tsyscall")
    f.write("\n\n\tli $v0,10\n\tsyscall")
  end
end
