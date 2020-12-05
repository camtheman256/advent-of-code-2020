seats = readlines("day5/input.txt")

function get_seat_id(seat::String)
    value = 128
    row_value = 0
    for i in 1:7
        value ÷= 2
        if seat[i] == 'B'
            row_value += value
        end
    end
    value = 8
    col_value = 0
    for i in 8:10
        value ÷= 2
        if seat[i] == 'R'
            col_value += value
        end
    end
    row_value*8 + col_value
end

println(maximum(get_seat_id, seats))

seat_ids = Set(map(get_seat_id, seats))

for i in 100:900
    if !(i in seat_ids)
        println(i)
        break
    end
end

# i coded this while watching a christmas romcom
# and it was far more pleasant than yesterday :)