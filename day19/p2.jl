infile = "day19/input2.txt"
rules, text = split(read(infile, String), "\n\n")
rules = split(rules, "\n")
text = split(text, "\n")

r_dict = Dict()
for rule in rules
    number, matchlist = match(r"(\d+): (.+)", rule).captures
    number = parse(Int, number)
    if contains(matchlist, "\"")
        r_dict[number] = matchlist[2]
    elseif contains(matchlist, "|")
        matchlist1, matchlist2 = split.(strip.(split(matchlist, "|")))
        matchlist1 = parse.(Int, matchlist1)
        matchlist2 = parse.(Int, matchlist2)
        r_dict[number] = (matchlist1, matchlist2)
    else
        r_dict[number] = parse.(Int, split(matchlist))
    end
end

function matches_rule(rule, text)
    global r_dict
    if text === nothing || text == ""
        return []
    end
    if isa(rule, Tuple)
        return vcat([matches_rule(rule[1], text), matches_rule(rule[2], text)]...)
    elseif isa(rule, Array)
        rem_text = [text]
        for r in rule
            rem_text = vcat(map(t -> matches_rule(r_dict[r], t), rem_text)...)
        end
        return rem_text
    elseif isa(rule, Char)
        if text[1] == rule
            return [text[2:end]]
        else
            return []
        end
    end
end

results = map(t -> matches_rule(r_dict[0], t), text)
println(count(r -> in("", r), results))