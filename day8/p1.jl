instructions = split.(readlines("day8/input.txt"), " ")

visited_lines = Set{Int}()

function execute_line(line_num, instruction, num, acc)
    if instruction == "nop"
        return line_num+1, acc
    elseif instruction == "jmp"
        return line_num+num, acc
    elseif instruction == "acc"
        return line_num+1, acc+num
    end
end

num, acc = execute_line(1, instructions[1][1], parse(Int, instructions[1][2]), 0)
push!(visited_lines, num)
while true
    global acc
    global num, acc = execute_line(num, instructions[num][1], parse(Int, instructions[num][2]), acc)
    if num in visited_lines
        println(acc)
        break
    end
    push!(visited_lines, num)
end