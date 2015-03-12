## Basic math operations: from string to byte code execution
### Simple compiler

If you want to see how it works in action:
  1. clone the project
  2. $ ruby ruby_string_compiler/execute.rb
  3. it takes digits (0-9), addition (+), multiplication (*) and parenthesis ( () )
  4. specs: $rspec ruby_string_compiler/spec.rb
  5. assmebly code is being overwritten each time in instructions.asm
  6. to see how it is being executed, download qtSpim simulator for MIPS processor (http://sourceforge.net/projects/spimsimulator/files/) and upload instructions.asm file directly there
  7. assmebly code includes printing out the result in the console of the simulator


### read more on my blog: www.letsleaveitempty.com
