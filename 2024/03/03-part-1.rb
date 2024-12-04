#!/usr/bin/env ruby

result = 0
f = File.new("input.txt")
# Gather Input
f.each_line do |line|
  line.scan(/mul\((\d+),(\d+)\)/).each do |m|
    result += m[0].to_i * m[1].to_i
  end
end
f.close

puts result
