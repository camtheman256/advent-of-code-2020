seats = reduce(vcat, permutedims.(collect.(readlines("day11/input.txt"))))

function step_seats!(seats)
    copy_seats = copy(seats)
    function execute_seat_rules(i, j)
        hi_i, hi_j = size(seats)
        function first_visible_seat(i_mod, j_mod, i_inner, j_inner)
            if 1 <= i_inner <= hi_i && 1 <= j_inner <= hi_j
                if copy_seats[i_inner, j_inner] == '.'
                    return first_visible_seat(i_mod, j_mod, i_inner+i_mod, j_inner+j_mod)
                else
                    return copy_seats[i_inner, j_inner]
                end
            end
            return ['.']
        end
        adj_seats = []
        for im in -1:1, jm in -1:1
            if im == 0 && jm == 0
                continue
            end
            push!(adj_seats, first_visible_seat(im, jm, i+im, j+jm))
        end
        if copy_seats[i, j] == 'L' && count(s -> s != '#', adj_seats) == length(adj_seats)
            seats[i,j] = '#'
        elseif copy_seats[i, j] == '#' && count(s -> s == '#', adj_seats) >= 5
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

# that was a super mess! never a bad day to code though :)