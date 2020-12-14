commands = readlines("day14/input.txt")

function mask_bits(mask, value)
    value_bits = bitstring(value)
    out_bitstring = []
    for i in 0:35
        if mask[end-i] == 'X'
            pushfirst!(out_bitstring, value_bits[end-i])
        else
            pushfirst!(out_bitstring, mask[end-i])
        end
    end
    return parse(Int, join(out_bitstring); base=2)
end

current_mask = ""
memory = Dict{Int, Int}()
for instruction in commands
    if contains(instruction, "[")
        address, value = match(r"mem\[(\d+)\] = (\d+)", instruction).captures
        global memory[parse(Int, address)] = mask_bits(current_mask, parse(Int, value))
    else
        global current_mask = match(r"mask = (\w+)", instruction).captures[1]
    end
end

println(sum(v for v in values(memory)))

# That was fun! Ending with a sub 1k place too!