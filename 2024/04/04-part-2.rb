#!/usr/bin/env ruby

module Matcher
  Steps = %w(M A S)

  def self.matches(data, x, y)
    return false if x < 1 or y < 1
    return false if x + 1 >= data.size
    return false if y + 1 >= data[x].size
    return false unless data[x][y] == 'A'

    has_cross? data, x, y
  end

  private

  def self.has_cross?(data, x, y)
    grab_line(data, x, y, 1) == 'AMS' && grab_line(data, x, y, -1) == 'AMS'
  end

  ## Grab a single 'cross', sort the characters, then join together
  def self.grab_line(data, x, y, direction)
    [data[x - 1][y - (1 * direction)], data[x][y], data[x + 1][y + (1 * direction)]].sort.join
  end
end

class Finder
  attr_accessor :data

  def initialize(data)
    self.data = data
  end

  def find
    result = 0

    data.each_index do |y|
      data[y].each_index do |x|
        result += 1 if Matcher.matches(data, x, y)
      end
    end

    result
  end
end

data = []

result = 0
f = File.new("input.txt")
# Gather Input
f.each_line do |line|
  chars = line.split('')
  data << chars
end
f.close

finder = Finder.new data



puts finder.find

