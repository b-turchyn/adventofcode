#!/usr/bin/env ruby

def parse_data(left, right)
  f = File.new("01-input.txt")
  # Gather Input
  f.each_line do |line|
    l = /(\d+)\s+(\d+)/.match(line)
    left << l[1].to_i
    right << l[2].to_i
  end

  f.close
end

def calculate_result(left, right)
  result = 0
  left.list.each {|v| result += right.similarity_score_of(v) }
  result
end

class ColumnFindings
  attr_accessor :list, :counts

  def initialize
    @list = []
    @counts = {}
    @counts.default = 0
  end

  def <<(val)
    @list << val
    @counts[val] = @counts[val] + 1
  end

  def similarity_score_of(val)
    return val * @counts[val]
  end
end

# Init data structures
left = ColumnFindings.new
right = ColumnFindings.new

parse_data left, right
puts calculate_result left, right
