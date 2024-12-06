#!/usr/bin/env ruby

class Rule
  attr_accessor :pre, :post

  def initialize(pre, post)
    @pre = pre
    @post = post
  end

  def valid? data
    return true unless data.include?(@pre)
    return true unless data.include?(@post)

    data.index(@pre) < data.index(@post)
  end
end

# Return the middle element
def midpoint(data)
  data[data.size / 2]
end

rules = []

result = 0
f = File.new("input.txt")
# Gather Input
f.each_line do |line|
  rule_line = /(\d+)\|(\d+)/.match line
  if rule_line
    rules << Rule.new(rule_line[1].to_i, rule_line[2].to_i)
  else
    next if line.strip.empty?
    pages = line.split(',').map {|a| a.to_i}
    valid = rules.all? {|r| r.valid? pages}

    puts "Midpoint = #{midpoint(pages)} of [#{pages.join(', ')}]"
    result += midpoint(pages) if valid
  end
end
f.close

puts result
