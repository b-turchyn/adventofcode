# 2023 Day 2

Two-part question:

1. How many of these games would be possible with 12 red, 13 green, and 14 blue
   cubes? _Sum up their game IDs_
2. What is the _sum of the powers_ of the minimum number of cubes required for
   each game?

## Possible Games

First, parse out the game ID using the same technique as Day 1. The game ID is
the first number.

```ruby
game = input[/\d+/].to_i
```

Split each game into each of the shown values, and then feed that data into a
separate method to get the max of each colour cube (there's probably a "Ruby-er"
way of doing this)

```ruby
shown_values = (input.sub /Game \d+: /, '').split '; '

[game, parse_shown_values(shown_values)]
```

`parse_shown_values` takes each of the shown values and finds the max of each
colour shown, returning that result as a `Hash`.

```ruby
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
```

We can then create a helper method to check if the game was possible by
filtering the inputted Hash based on the maximum defined values for a game.

```ruby
MAX_POSSIBLE = {
  "red" => 12,
  "green" => 13,
  "blue" => 14
}

def possible?(max_possible_values)
  max_possible_values.select {|k, v| MAX_POSSIBLE[k] < v}.empty?
end
```

Finally, loop through the file like we did on Day 1, adding up the Game IDs if
the game was possible.

```ruby
total = 0

f = File.open '02-input.txt'
f.each_line do |line|
  # Get the data
  id, line_data = parse_line line

  # Possible?
  total += id if possible?(line_data)
end
f.close

puts "Sum of IDs of possible games: #{total}"
```

## Sum Of Powers

We already have most of the groundwork laid for this. One more helper method is
all that's mainly required. Multiply each of the values in the Hash together.

```ruby
def power(max_possible_values)
  max_possible_values.values.reduce &:*
end
```

Then, put into the loop to handle it at the same time

```ruby
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
```

