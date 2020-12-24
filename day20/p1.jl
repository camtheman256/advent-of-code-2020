fn = "day20/input.txt"
tiles_text = split(read(fn, String), "\n\n")

struct Tile
    id::Int
    geo::Array{Bool, 2}
end

tiles = []
for tile_text in tiles_text
    tile_lines = split(tile_text, "\n")
    tile_id = parse(Int, match(r"Tile (\d+):", tile_lines[1]).captures[1])
    tile_geo = [[s == '#' for s in tile_line] for tile_line in tile_lines[2:end]]
    tile_geo = vcat(permutedims.(tile_geo)...)
    push!(tiles, Tile(tile_id, tile_geo))
end

function edges(t::Tile)
    return [t.geo[1, 1:end], t.geo[end, 1:end], t.geo[1:end, 1], t.geo[1:end, end]]
end

corners = []
for tile in tiles
    matching_edges = -4
    my_edges = edges(tile)
    for tile2 in tiles
        matching_edges += count(e -> e in my_edges || reverse(e) in my_edges, edges(tile2))
    end
    if matching_edges == 2
        push!(corners, tile.id)
    end
end

println(prod(corners))