#!/usr/bin/env ruby

module Matcher
  Steps = %w(X M A S)

  def self.matches(data, x, y)
    result = 0
    (-1..1).each do |y_direction|
      (-1..1).each do |x_direction|
        result += 1 if matches_direction(data, x, y, x_direction, y_direction)
      end
    end
    result
  end

  private

  def self.matches_direction(data, x_start, y_start, x_direction, y_direction)
    Matcher::Steps.each_index do |i|
      expected = Matcher::Steps[i]
      x = x_start + (x_direction * i)
      y = y_start + (y_direction * i)

      return false if x < 0 or y < 0
      return false if x >= data.size
      return false if y >= data[x].size
      actual = data[x][y]

      return false unless expected == actual
    end

    true
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
        result += Matcher.matches(data, x, y)
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
