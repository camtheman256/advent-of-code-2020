nums = parse.(Int, readlines("day10/input.txt"))

push!(nums, 0)
push!(nums, 3+maximum(nums))
sort!(nums)

println(nums)

dp = Dict()
function dp_proxy(i)
    if i in keys(dp)
        return dp[i]
    else
        result = connect_suffix(i)
        dp[i] = result
        return result
    end
end

function connect_suffix(i)
    global nums
    num_ways = 0
    if i == length(nums)
        return 1
    end
    if i + 1 <= length(nums) && (nums[i]+1 <= nums[i + 1] <= nums[i]+3)
        num_ways += dp_proxy(i+1)
    end
    if i + 2 <= length(nums) && (nums[i]+1 <= nums[i + 2] <= nums[i]+3)
        num_ways += dp_proxy(i+2)
    end
    if i + 3 <= length(nums) && (nums[i]+1 <= nums[i + 3] <= nums[i]+3)
        num_ways += dp_proxy(i+3)
    end
    return num_ways
end

println(connect_suffix(1))

# holy hell DP! that was exciting!