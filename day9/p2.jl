nums = parse.(Int, readlines("day9/input.txt"))

for i in 1:length(nums), j in i+1:length(nums)
    if sum(nums[i:j]) == 15353384
        println(minimum(nums[i:j])+maximum(nums[i:j]))
    end
end

# 464!! I'm proud of this one :D