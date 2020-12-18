exprs = map(s -> replace(s, '*' => '⨣'), readlines("day18/input.txt"))
exprs = map(s -> replace(s, '+' => '⨱'), exprs)

# picking an operator that looks like a plus gives it the precedence of addition
⨣(a, b) = a * b
⨱(a, b) = a + b

println(reduce((v, l) -> v + eval(Meta.parse(l)), exprs; init=0))