nums = Set(parse.(Int, readlines("day1/input.txt")))

for elt in nums
    if 2020-elt in nums
        print(elt*(2020-elt))
        break
    end
end