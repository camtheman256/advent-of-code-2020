nums = parse.(Int, readlines("day10/input.txt"))

push!(nums, 0)
push!(nums, 3+maximum(nums))
sort!(nums)

println(nums)
println(count(i -> (nums[i] - nums[i-1]) == 1, 2:length(nums))*count(i -> (nums[i] - nums[i-1]) == 3, 2:length(nums)))