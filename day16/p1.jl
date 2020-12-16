ranges, my_ticket, all_tickets = split(read("day16/input.txt", String), "\n\n")

ranges = split(ranges, "\n")
my_ticket = split(my_ticket, "\n")[2]
all_tickets = split(all_tickets, "\n")[2:end]

valid_nums = Set{Int}()

for r in ranges
    s1, e1, s2, e2 = parse.(Int, match(r"(\d+)-(\d+) or (\d+)-(\d+)", r).captures)
    push!(valid_nums, s1:e1..., s2:e2...)
end

out = 0
for t in all_tickets
    t_nums = parse.(Int, split(t, ","))
    global out += sum(filter(n -> !(n in valid_nums), t_nums))
end

println(out)