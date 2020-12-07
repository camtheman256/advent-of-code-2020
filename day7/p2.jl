rules_text = readlines("day7/input.txt")

struct Bag
    adjective::String
    color::String
end

struct BagRule
    bag::Bag
    holds::Set{Tuple{Int, Bag}}
end


function parse_bag(line::String)
    adj, color = match(r"^(\w+) (\w+) bags", line).captures
    other_bags = Set{Tuple{Int, Bag}}()
    for match in eachmatch(r"(\d) (\w+) (\w+) bag[s]?", line)
        num, adj_inside, color_inside = match.captures
        push!(other_bags, (parse(Int, num), Bag(adj_inside, color_inside)))
    end
    return BagRule(Bag(adj, color), other_bags)
end

bags_rules = parse_bag.(rules_text)

function contains_bags(bag::Bag)
    global bags_rules
    bag_rule = bags_rules[findfirst(b -> b.bag == bag, bags_rules)]
    bags_inside = 0
    for (num, bag) in bag_rule.holds
        bags_inside += num*contains_bags(bag)
        bags_inside += num
    end
    return bags_inside
end

println(contains_bags(Bag("shiny", "gold")))

# that was harder, but we got through it!
# and it was fun! :D