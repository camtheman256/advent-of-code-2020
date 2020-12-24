infile = "day19/input.txt"
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
        return nothing
    end
    if isa(rule, Tuple)
        if (firstmatch = matches_rule(rule[1], text)) === nothing
            return matches_rule(rule[2], text)
        end
        return firstmatch
    elseif isa(rule, Array)
        rem_text = text
        for r in rule
            rem_text = matches_rule(r_dict[r], rem_text)
        end
        return rem_text
    elseif isa(rule, Char)
        if text[1] == rule
            return text[2:end]
        end
    end
end

println(count(t -> matches_rule(r_dict[0], t) == "", text))