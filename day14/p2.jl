commands = readlines("day14/input.txt")

function decode_addresses(mask, value)
    value_bits = bitstring(value)
    out_bits = []
    for i in 0:35
        if mask[end-i] == '0'
            pushfirst!(out_bits, value_bits[end-i])
        else
            pushfirst!(out_bits, mask[end-i])
        end
    end
    out_bitstring = join(out_bits)
    addresses_out = [out_bitstring]
    while contains(addresses_out[1], 'X')
        address = popfirst!(addresses_out)
        idx = findfirst('X', address)
        push!(addresses_out, address[1:idx-1]*"0"*address[idx+1:end], address[1:idx-1]*"1"*address[idx+1:end])
    end
    return addresses_out
end

current_mask = ""
memory = Dict{Int, Int}()
for instruction in commands
    if contains(instruction, "[")
        address, value = match(r"mem\[(\d+)\] = (\d+)", instruction).captures
        for address in decode_addresses(current_mask, parse(Int, address))
            global memory[parse(Int, address; base=2)] = parse(Int, value)
        end
    else
        global current_mask = match(r"mask = (\w+)", instruction).captures[1]
    end
end

println(sum(v for v in values(memory)))