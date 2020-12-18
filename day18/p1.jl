exprs = replace.(readlines("day18/input.txt"), '*' => '⨣')

⨣(a, b) = a * b

println(reduce((v, l) -> v + eval(Meta.parse(l)), exprs; init=0))