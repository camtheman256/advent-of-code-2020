passports = readlines("day4/input.txt")

passports_dicts = []
current_passport = Dict()
for line in passports
    global current_passport, passports_dicts
    if line == ""
        push!(passports_dicts, current_passport)
        current_passport = Dict()
        continue
    end
    push!(current_passport, [s[1] => s[2] for s in split.(split(line, " "), ":")]...)
end
push!(passports_dicts, current_passport)

println(count(p -> issubset(["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"], keys(p)), passports_dicts))

valid_passports = 0
for passport in passports_dicts
    if !issubset(["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"], keys(passport))
        continue
    end
    for (k, v) in pairs(passport)
        passport[k] = convert(String, v)
    end
    valid = length(passport["byr"]) == 4 && 1920 <= parse(Int, passport["byr"]) <= 2002
    valid = valid && length(passport["iyr"]) == 4 && 2010 <= parse(Int, passport["iyr"]) <= 2020
    valid = valid && length(passport["eyr"]) == 4 && 2020 <= parse(Int, passport["eyr"]) <= 2030
    valid = valid && begin
        result = false
        match_string = convert(String, passport["hgt"])
        if length(match_string) >= 4 && match_string[end-1:end] == "cm"
            result = 150 <= parse(Int, match_string[1:end-2]) <= 193
        elseif length(match_string) >= 4 && match_string[end-1:end] == "in"
            result = 59 <= parse(Int, match_string[1:end-2]) <= 76
        end
        result
    end
    valid = valid && match(r"^#[0-9a-f]{6}$", passport["hcl"]) !== nothing
    valid = valid && passport["ecl"] in ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]
    valid = valid && match(r"^[0-9]{9}$", passport["pid"]) !== nothing
    global valid_passports += valid
end

println(valid_passports)

# oh my god that was horrible lol