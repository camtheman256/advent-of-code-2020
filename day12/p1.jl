instructions = readlines("day12/input.txt")

mutable struct Ship
    x::Int
    y::Int
    angle::Int
end

ship = Ship(0, 0, 0)

function step_instruction(instruction)
    global ship
    command, amount = instruction[1], parse(Int, instruction[2:end])
    if command == 'N'
        ship.y += amount
    elseif command == 'S'
        ship.y -= amount
    elseif command == 'E'
        ship.x += amount
    elseif command == 'W'
        ship.x -= amount
    elseif command == 'L'
        ship.angle = mod((ship.angle + amount), 360)
    elseif command == 'R'
        ship.angle = mod((ship.angle - amount), 360)
    elseif command == 'F'
        directions = Dict(90 => 'N', 180 => 'W', 270 => 'S', 0 => 'E')
        step_instruction(directions[ship.angle] * string(amount))
    end
end

for ins in instructions
    step_instruction(ins)
end

println(abs(ship.x)+abs(ship.y))