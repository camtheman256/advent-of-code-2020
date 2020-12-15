numbers = [0,14,1,3,7,9]
# numbers = [1,3,2]
# numbers = [0,3,6]
# numbers = [2,1,3]

function get_next_number!(spoken, last_number, current_idx)
    if !(last_number in keys(spoken))
        spoken[last_number] = current_idx - 1
        return 0
    else
        result = current_idx - spoken[last_number] - 1
        spoken[last_number] = current_idx - 1
        return result
    end
end

spoken_history = Dict(n[2] => n[1] for n in enumerate(numbers[1:end-1]))
last_spoken = numbers[end]
for i in length(numbers)+1:30000000
    global spoken_history
    global last_spoken = get_next_number!(spoken_history, last_spoken, i)
end

println(last_spoken)