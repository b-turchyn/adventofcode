MAX_POSSIBLE = {
  "red" => 12,
  "green" => 13,
  "blue" => 14
}

# Split out the relevant data
def parse_line(input)
  game = input[/\d+/].to_i
  shown_values = (input.sub /Game \d+: /, '').split '; '

  [game, parse_shown_values(shown_values)]
end

# Figure out the maximum number of each colour shown
def parse_shown_values(shown_values)
  max_possible_values = Hash.new
  shown_values.each do |shown|
    colours = shown.split ', '
    colours.each do |c|
      count, colour = c.split ' '

      if max_possible_values[colour].nil? || count.to_i > max_possible_values[colour]
        max_possible_values[colour] = count.to_i
      end
    end
  end

  max_possible_values
end

def possible?(max_possible_values)
  max_possible_values.select {|k, v| MAX_POSSIBLE[k] < v}.empty?
end

def power(max_possible_values)
  max_possible_values.values.reduce &:*
end

total = 0
sum_of_powers = 0

f = File.open '02-input.txt'
f.each_line do |line|
  # Get the data
  id, line_data = parse_line line
  # Add the sum of powers
  sum_of_powers += power(line_data)

  # Possible?
  total += id if possible?(line_data)
end
f.close

puts "Sum of IDs of possible games: #{total}"
puts "Sum of powers: #{sum_of_powers}"
