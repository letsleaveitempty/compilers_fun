# digit  ::= '0' | '1' | '2' | '3' | '4' | '5' | '6' | '7' | '8' | '9';
# number ::= digit | digit, number;
#
# bracket ::= opening_bracket | closing_bracket;
# opening_bracket ::= '(';
# closing_bracket ::= ')';
#
# expression ::=   expression + primary_expression
#                | expression - primary_expression
#                | primary_expression;
#
# primary_expression ::=    expression * primary_expression
#                         | expression / primary_expression
#                         | opening_bracket, expression, closing_bracket
#                         | number;
#
# node ::= expression | number;


###
### right side recursion
digit  ::= '0' | '1' | '2' | '3' | '4' | '5' | '6' | '7' | '8' | '9';
number ::= digit | digit, number;

bracket ::= opening_bracket | closing_bracket;
opening_bracket ::= '(';
closing_bracket ::= ')';

expression ::=   primary_expression + expression
               | primary_expression - expression
               | primary_expression;

primary_expression ::=    expression * primary_expression
                        | expression / primary_expression
                        | opening_bracket, expression, closing_bracket
                        | number;

node ::= expression | number;


###
### left side recursion
digit  ::= '0' | '1' | '2' | '3' | '4' | '5' | '6' | '7' | '8' | '9';
number ::= digit | number, digit;

bracket ::= opening_bracket | closing_bracket;
opening_bracket ::= '(';
closing_bracket ::= ')';

expression ::=   expression + primary_expression
               | expression - primary_expression
               | primary_expression;

primary_expression ::=    primary_expression * expression
                        | primary_expression / expression
                        | opening_bracket, expression, closing_bracket
                        | number;

node ::= expression | number;
