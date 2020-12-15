numbers = [0,14,1,3,7,9]
# numbers = [1,3,2]
# numbers = [2,1,3]

function get_next_number!(spoken)
    idx = findlast(==(spoken[end]), spoken[1:end-1])
    if idx === nothing
        push!(spoken, 0)
    else
        push!(spoken, length(spoken) - idx)
    end
end

spoken_history = [numbers...]
for i in length(numbers)+1:2020
    global spoken_history
    get_next_number!(spoken_history)
end

println(spoken_history[end])
