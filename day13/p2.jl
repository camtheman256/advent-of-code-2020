input = readlines("day13/input.txt")
# input = readlines("day13/small.txt")
# input = readlines("day13/tiny.txt")
depart_time = parse(Int, input[1])
buses = convert.(String, split(input[2], ","))
numeric_buses = filter(n -> tryparse(Int, n[2]) !== nothing, collect(enumerate(buses)))
numeric_buses = map(n -> (n[1], parse(Int, n[2])), numeric_buses)

println(numeric_buses)
function special_mod(a, b)
    return mod(a, b) == 0 ? b : mod(a,b)
end

prev_buses = [1]
on = 0
for (idx, bus) in numeric_buses
    global prev_buses, on
    search_by = prod(prev_buses)
    condition = (num) -> (bus - special_mod(num, bus) == mod(idx - 1, bus))
    while !condition(on)
        on += search_by
    end
    push!(prev_buses, bus)
end

println(on)

# You gotta love modular arithmetic! Today's was fun!