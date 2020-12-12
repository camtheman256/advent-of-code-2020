instructions = readlines("day12/input.txt")

mutable struct Waypoint
    x::Int
    y::Int
end

mutable struct Ship
    x::Int
    y::Int
end

waypoint = Waypoint(10, 1)
ship = Ship(0,0)

function step_instruction(instruction)
    global waypoint
    command, amount = instruction[1], parse(Int, instruction[2:end])
    if command == 'N'
        waypoint.y += amount
    elseif command == 'S'
        waypoint.y -= amount
    elseif command == 'E'
        waypoint.x += amount
    elseif command == 'W'
        waypoint.x -= amount
    elseif command == 'L'
        for i in 1:(amount ÷ 90)
            waypoint.x, waypoint.y = (-waypoint.y, waypoint.x)
        end
    elseif command == 'R'
        for i in 1:(amount ÷ 90)
            waypoint.x, waypoint.y = (waypoint.y, -waypoint.x)
        end
    elseif command == 'F'
        for i in 1:amount
            ship.x += waypoint.x
            ship.y += waypoint.y
        end
    end
end

for ins in instructions
    step_instruction(ins)
end

println(abs(ship.x)+abs(ship.y))

# row row row your boat