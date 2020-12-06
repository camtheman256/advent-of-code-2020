groups_text = split(read("day6/input.txt", String), "\n\n")

groups = split.(groups_text, "\n")

value = 0
for group in groups
    group_questions = Set{Char}()
    for person in group
        push!(group_questions, collect(person)...)
    end
    global value += length(group_questions)
end

println(value)