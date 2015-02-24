require_relative 'parser'

parser = Parser.new

loop do
  begin
    print '>> '
    puts parser.parse(gets)
  rescue RuntimeError
    puts 'Error occured: ' + $!
  end
end
