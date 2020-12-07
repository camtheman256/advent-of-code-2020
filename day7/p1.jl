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


function contains_shiny_gold(bag)
    global bags_rules
    bag_rule = bags_rules[findfirst(b -> b.bag == bag, bags_rules)]
    if count(b -> b[2].adjective == "shiny" && b[2].color == "gold", bag_rule.holds) > 0
        return true
    end
    for (num, bag) in bag_rule.holds
        if contains_shiny_gold(bag)
            return true
        end
    end
    return false
end

println(count(br -> contains_shiny_gold(br.bag), bags_rules))