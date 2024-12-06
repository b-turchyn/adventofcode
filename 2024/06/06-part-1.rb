#!/usr/bin/env ruby

DIRECTIONS = [[1, 0], [0, 1], [-1, 0], [0, -1]]

# Every possible direction we can move
class Map
  attr_accessor :data, :current_position, :direction

  def initialize
    @data = []
  end

  def add_row(data)
    @data << data.split('').map {|d| Position.new(d)}
  end

  def solve
    @current_position = get_starting_position
    @direction = player.direction

    puts "Starting position is at #{@current_position.join(',')}"
    puts "Direction is #{@direction}"

    # Until we walk off the map
    until off_map?
      walk!
    end

    count_walked
  end

  def count_walked
    @data.map do |row|
      row.count {|p| p.walked? }
    end.reduce( &:+ )
  end

  private

  def player
    data_at @current_position
  end

  def data_at(pos)
    @data[pos[1]][pos[0]]
  end

  def walk!
    player.walk
    new_position = [@current_position[0] + @direction[0], @current_position[1] + @direction[1]]

    while !off_map?(new_position) and data_at(new_position).obstacle?
      puts "Found an obstacle; rotating clockwise"
      @direction = DIRECTIONS[(DIRECTIONS.index(@direction) + 1) % DIRECTIONS.size]
      new_position = [@current_position[0] + @direction[0], @current_position[1] + @direction[1]]
    end

    puts "Moving to [#{new_position.join(',')}] via heading [#{@direction.join(',')}]"

    @current_position = new_position
  end

  def get_starting_position
    @data.each_index do |y|
      @data[y].each_index do |x|
        return [x, y] if @data[y][x].player?
      end
    end
  end

  def off_map?(pos = nil)
    pos ||= @current_position
    return true if pos[0] < 0 || pos[1] < 0
    return true if @data.size <= pos[1]
    return true if @data[pos[1]].size <= pos[0]

    false
  end
end

class Position
  attr_accessor :data, :walked

  def initialize(data)
    @data = data
  end

  def player?
    %w(v < > ^).include? @data
  end

  def direction
    return case @data
    when 'v'
      [0, 1]
    when 'V'
      [0, 1]
    when '^'
      [0, -1]
    when '<'
      [-1, 0]
    when '>'
      [1, 0]
    else
      "ERROR: I failed! #{@data}"
    end
  end

  def open?
    @data == '.'
  end

  def obstacle?
    @data == '#'
  end

  def walk
    @walked = true
  end

  def walked?
    !!@walked
  end
end

result = 0
map = Map.new

f = File.new("input.txt")
# Gather Input
f.each_line do |line|
  map.add_row line
end
f.close

puts map.solve
