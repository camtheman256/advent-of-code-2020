struct NewPolicy
    letter::Char
    first_position::Int
    second_position::Int
end

satisfies_policy(pw::AbstractString, p::NewPolicy) = (pw[p.first_position] == p.letter) != (pw[p.second_position] == p.letter)

passwords = split.(readlines("day2/input.txt"))
out = 0
for (range, char_text, password) in passwords
    first_pos, second_pos = parse.(Int, split(range, "-"))
    pw_policy = NewPolicy(char_text[1], first_pos, second_pos)
    global out += satisfies_policy(password, pw_policy)
end

print(out)