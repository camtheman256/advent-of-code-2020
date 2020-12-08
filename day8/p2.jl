function completes_successfully(swap_line)
    instructions = split.(readlines("day8/input.txt"), " ")

    if instructions[swap_line][1] == "acc"
        return false
    end
    instructions[swap_line][1] = instructions[swap_line][1] == "jmp" ? "nop" : "jmp"
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
        acc
        num, acc = execute_line(num, instructions[num][1], parse(Int, instructions[num][2]), acc)
        if num in visited_lines || !(1 <= num <= 652)
            return false
        end
        if num == 652
            return acc
        end
        push!(visited_lines, num)
    end
    return false
end

println([completes_successfully(n) for n in 1:651])

# see if you can spot the answer in the output!
# that was a bit messy :P