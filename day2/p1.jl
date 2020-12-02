struct Policy
    letter::Char
    min_count::Int
    max_count::Int
end

satisfies_policy(pw::AbstractString, p::Policy) = p.min_count <= count(l -> l == p.letter, pw) <= p.max_count

passwords = split.(readlines("day2/input.txt"))
out = 0
for (range, char_text, password) in passwords
    min_count, max_count = parse.(Int, split(range, "-"))
    pw_policy = Policy(char_text[1], min_count, max_count)
    global out += satisfies_policy(password, pw_policy)
end

print(out)