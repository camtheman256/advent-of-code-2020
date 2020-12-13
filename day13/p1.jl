input = readlines("day13/input.txt")
# input = readlines("day13/small.txt")
depart_time = parse(Int, input[1])
buses = convert.(String, split(input[2], ","))

min_mod, min_bus = 10000000000, 0
for bus in buses
    global min_mod,min_bus
    if tryparse(Int, bus) !== nothing
        minimize = parse(Int, bus) - mod(depart_time, parse(Int, bus))
        if minimize < min_mod
            min_mod = minimize
            min_bus = parse(Int, bus)
        end
    end
end

println(min_mod)
println(min_bus)

println(min_mod*min_bus)