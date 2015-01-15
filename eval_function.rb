def eval(ast)
  if ast.is_a?(Fixnum)
    ast
  else
    eval(ast[1]) + eval(ast[2])
  end
end

my_ast = ["+", ["+", 4, 5], 6]
puts eval(my_ast)
