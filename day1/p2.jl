nums = Set(parse.(Int, readlines("day1/input.txt")))

sums = Dict(i+j => (i, j) for i in nums, j in nums)

for elt in nums
    if (2020-elt) in keys(sums)
        print(elt*prod(sums[2020-elt]))
        break
    end
end