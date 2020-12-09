nums = parse.(Int, readlines("day9/input.txt"))

function satisfies_preamble(line_num)
    for i in line_num-25:line_num-1, j in i+1:line_num-1
        if nums[i]+nums[j] == nums[line_num]
            return true
        end
    end
    return false
end

println(nums[25+findfirst(!satisfies_preamble, 26:length(nums))])