# Day 1

Our goal:
- Find the first and last digit on each line
- Concatenate those together, then treat as a number (rather than a String)
- Sum up each line

## Finding Digits

We can use [String#[]](https://devdocs.io/ruby~3.2/string#method-i-5B-5D) to
find the first digit in a string; reversing the String will find us the last
digit.

```ruby
word[/\d/] # Finds the first digit in a word
```

To get both:

```ruby
def find_digits(word)
  [word[/\d/], word.reverse[/\d/]]
end
```

## Calibration Value For One Line

We then take the digits, concatenate them together, and convert them to a
number.

```ruby
def calibration_value(word)
  find_digits(word).join('').to_i
end
```

## Sum Up Each Line

We now need to read the input data line by line.
[IO#each_line](https://devdocs.io/ruby~3.2/io#method-i-each_line) is perfectly
equipped to do this, as it streams the input rather than reading the entire
file. Not a big deal in this scenario, but for larger data this would become a
big memory problem.

Output the result at the end, so we can read it!

```ruby
total = 0

f = File.new("01-input.txt")
f.each_line {|line| total += calibration_value line}
f.close

puts total
```

And there we go.
