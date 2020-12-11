seats = reduce(vcat, permutedims.(collect.(readlines("day11/input.txt"))))

function step_seats!(seats)
    copy_seats = copy(seats)
    function execute_seat_rules(i, j)
        hi_i, hi_j = size(seats)
        adjacent_seats = copy_seats[max(1, i-1):min(i+1, hi_i), max(1, j-1):min(j+1, hi_j)]
        if copy_seats[i, j] == 'L' && count(s -> s != '#', adjacent_seats) == length(adjacent_seats)
            seats[i,j] = '#'
        elseif copy_seats[i, j] == '#' && count(s -> s == '#', adjacent_seats) >= 5
            seats[i,j] = 'L'
        end
    end

    for i in 1:size(seats, 1), j in 1:size(seats, 2)
        execute_seat_rules(i, j)
    end
end

old_seats = nothing
while old_seats != seats
    global old_seats = copy(seats)
    step_seats!(seats)
end

println(count(s -> s == '#', seats))