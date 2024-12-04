#!/usr/bin/env ruby

result = 0
enabled = true

f = File.new("input.txt")
# Gather Input

f.each_line do |line|
  line.scan(/(mul\((\d+),(\d+)\)|do\(\)|don't\(\))/).each do |token|
    if token[0].start_with? 'mul'
      result += token[1].to_i * token[2].to_i if enabled
    elsif token[0].start_with? "don't"
      enabled = false
    elsif token[0].start_with? "do"
      enabled = true
    else
      puts "WTAF?! #{token}"
    end
  end
end
f.close

puts result

class Token
  attr_reader :name

  def valid?(input)
    true
  end
end

class Multiply < Token
  def name; "mul"; end

  def valid?(input)
    enabled && input.split(',').size == 2
  end
  
  def parse(input)
    input.split(',').map {|a| a.to_i}.reduce :*
  end
end

class Do < Token
  def name; "do"; end

  def parse(input)
    enabled = true
  end
end

class Dont < Token
  def name; "don't"; end

  def parse(input)
    enabled = false
  end
end

tokens = [Multiply.new, Do.new, Dont.new]
