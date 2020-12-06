groups_text = split(read("day6/input.txt", String), "\n\n")

groups = split.(groups_text, "\n")

value = 0
for group in groups
    group_questions = Dict{Char, Int}()
    for person in group
        for letter in person
            if letter in keys(group_questions)
                group_questions[letter] += 1
            else
                group_questions[letter] = 1
            end
        end
    end
    global value += count(p -> p[2] == length(group), group_questions)
end

println(value)