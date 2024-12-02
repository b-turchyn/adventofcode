#!/usr/bin/env ruby

def is_safe(line)
  # Split the line by whitespace and convert to numeric values
  vals = line.split(/\s+/).map {|s| s.to_i}

  # No need to have a "check the whole thing" scenario; this would still pass
  # if we remove the start or end of a valid report.
  (0...vals.size).map do |i|
    subset = vals[0...i] + vals[i+1...vals.size]
    # The report is safe if both checks pass
    is_sorted(subset) and is_change_in_range(subset)
  end.any? true
end

## Check if they're sorted, or sorted in reverse
def is_sorted(vals)
  vals.sort == vals || vals.sort == vals.reverse
end

def is_change_in_range(vals)
  vals.each_index do |i|
    tuple = vals[i..i+1].sort!
    break if tuple.size != 2 # Safety valve for the last entry
    
    # If the difference isn't in range, fail fast
    return false unless (1..3).include? (tuple[1] - tuple[0])
  end

  # If we made it this far, the report is safe
  true
end

safe_count = 0

f = File.new("02-input.txt")
# Gather Input
f.each_line do |line|
  safe_count += 1 if is_safe line
end
f.close

puts safe_count
