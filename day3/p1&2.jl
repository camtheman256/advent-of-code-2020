struct TobogganGeology
    map::Array{Char, 2}
end

Base.getindex(a::TobogganGeology, i::Int, j::Int) = let
    new_j = j % size(a.map, 2)
    new_j = new_j == 0 ? size(a.map, 2) : new_j
    a.map[i, new_j]
end

text = reduce(vcat, permutedims.(collect.(readlines("day3/input.txt"))))

t = TobogganGeology(text)

function run_slope_guy(right::Int, down::Int)
    global t
    start = (1, 1)
    trees = 0
    while start[1] <= size(t.map, 1)
        trees += t[start...] == '#'
        start = (start[1] + down, start[2] + right)
    end
    return trees
end

println(run_slope_guy(3, 1))

println(run_slope_guy(1,1)*run_slope_guy(3,1)*run_slope_guy(5,1)*run_slope_guy(7,1)*run_slope_guy(1,2))