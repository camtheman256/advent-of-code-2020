cube = map(c -> c == '#', vcat(permutedims.(collect.(readlines("day17/input.txt")))...))
# cube = map(c -> c == '#', vcat(permutedims.(collect.(readlines("day17/small.txt")))...))
cube = reshape(cube, size(cube)..., 1, 1)

function step_cube(cube)
    # pad cube
    cube_new = zeros(Bool, size(cube) .+ 2)
    # copy data into new cube
    for r in 1:size(cube, 1), c in 1:size(cube, 2), p in 1:size(cube, 3), w in 1:size(cube, 4)
        cube_new[r+1, c+1, p+1, w+1] = cube[r, c, p, w]
    end
    # retain cube for study
    cube_study = copy(cube_new)
    # run thru dims
    mr, mc, mp, mw = size(cube_new)
    for r in 1:size(cube_new, 1), c in 1:size(cube_new, 2), p in 1:size(cube_new, 3), w in 1:size(cube_new, 4)
        neighbors = cube_study[max(1, r-1):min(r+1, mr), max(1, c-1):min(c+1, mc), max(1, p-1):min(p+1, mp), max(1, w-1):min(w+1, mw)]
        if cube_study[r, c, p, w] && !(count(neighbors) in [3, 4])
            cube_new[r, c, p, w] = false
        elseif !cube_study[r, c, p, w] && count(neighbors) == 3
            cube_new[r, c, p, w] = true
        end
    end
    return cube_new
end

for i in 1:6
    global cube
    cube = step_cube(cube)
end

println(count(cube))