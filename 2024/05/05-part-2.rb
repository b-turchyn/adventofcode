#!/usr/bin/env ruby

class Rule
  attr_accessor :pre, :post

  def initialize(pre, post)
    @pre = pre
    @post = post
  end

  ## Rules are valid if either page isn't present, or the "pre" page is before the "post" page
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

def repair(rules, data)
  # Get all rules that failed
  failing_rules = rules.filter {|rule| !rule.valid? data}
  # For each rule, find @post and move after @pre
  # We know that both values must exist, so we can blindly delete the post and then just insert after the pre
  failing_rules.each do |rule|
    # Verify that a previous fix hasn't fixed this
    next if rule.valid? data

    data.delete(rule.post)
    data.insert(data.index(rule.pre) + 1, rule.post)
  end

  data
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
    # Is the line empty? Skip it!
    next if line.strip.empty?
    pages = line.split(',').map {|a| a.to_i}

    # Is this line valid? Skip it!
    valid = rules.all? {|r| r.valid? pages}
    next if valid

    # Repair until fixed, then midpoint it
    while !rules.all? {|r| r.valid? pages}
      pages = repair(rules, pages)
    end

    result += midpoint(pages)
  end
end
f.close

puts result
