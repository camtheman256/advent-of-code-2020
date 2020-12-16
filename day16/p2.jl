ranges, my_ticket, all_tickets = split(read("day16/input.txt", String), "\n\n")
# ranges, my_ticket, all_tickets = split(read("day16/small.txt", String), "\n\n")

ranges = split(ranges, "\n")
my_ticket = parse.(Int, split(split(my_ticket, "\n")[2], ","))
all_tickets = split(all_tickets, "\n")[2:end]

all_ranges = []

for r in ranges
    s1, e1, s2, e2 = parse.(Int, match(r"(\d+)-(\d+) or (\d+)-(\d+)", r).captures)
    push!(all_ranges, Set([s1:e1..., s2:e2...]))
end

all_valid_nums = union(all_ranges...)

filter!(r -> all(n -> (n in all_valid_nums), parse.(Int, split(r, ","))), all_tickets)

all_tickets = parse.(Int, vcat(permutedims.(split.(all_tickets, ","))...))

matches_col(c, valid_set) = all(n -> n in valid_set, all_tickets[:, c])

matches_per_rule = [Set(filter(c -> matches_col(c, all_ranges[i]), 1:size(all_tickets, 2))) for i in 1:length(all_ranges)]

println(matches_per_rule)

function range_solver(start_col, taken_cols)
    if start_col == length(all_ranges)+1
        return []
    end
    for c in 1:size(all_tickets, 2)
        if c in taken_cols
            continue
        end
        if c in matches_per_rule[start_col]
            result = range_solver(start_col+1, Set([taken_cols..., c]))
            if result !== nothing
                return vcat([c], result)
            end
        end
    end
end

cols = range_solver(1, Set())

println(prod(i -> my_ticket[i], cols[1:6]))

# not proud of this guy, but it does the job