#!/usr/bin/env ruby

left = []
right = []

f = File.new("01-input.txt")
# Gather Input
f.each_line do |line|
  l = /(\d+)\s+(\d+)/.match(line)
  left << l[1].to_i
  right << l[2].to_i
end
f.close

# Sort the contents
left.sort!
right.sort!

result = 0
left.each_index {|i| result += (left[i] - right[i]).abs }

puts result
