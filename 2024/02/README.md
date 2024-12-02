# 2024 Day 2

## Part 1

Our goal:

- Parse each line by splitting on whitespace, then convert each entry to a
  number
- Perform the first check to see if it's sorted (or inverted sorted)
- Check each tuple to see that the difference between the two is within an
  acceptable range

### Parsing

EZPZ.

```ruby
vals = line.split(/\s+/).map {|s| s.to_i}
```

### Sort Check

Sort, then see if it matches either the original value or the reversed original
value.

```ruby
def is_sorted(vals)
  vals.sort == vals || vals.sort == vals.reverse
end
```

### Tuple Difference Check

Grab pairs. Break out if the pair we grabbed has only one value, since that
means you're at the end.

```ruby
vals.each_index do |i|
  tuple = vals[i..i+1].sort!
  break if tuple.size != 2 # Safety valve for the last entry
  
  # ...
end
```

Check if the difference is within a range. Throw some Ruby spice on it.

```ruby
return false unless (1..3).include? (tuple[1] - tuple[0])
```

## Part 2

A report is considered safe if the removal of one entry results in a passing
test with the previous criteria.

There's probably a simpler way other than just removing an index one by one and
testing the result, but I couldn't think of one.

I modified my `is_safe` method to handle this.

```ruby
def is_safe(line)
  # Split the line by whitespace and convert to numeric values
  vals = line.split(/\s+/).map {|s| s.to_i}

  # No need to have a "check the whole thing" scenario; this would still pass
  # if we remove the start or end of a valid report.
  (0...vals.size).map do |i|
    subset = vals[0...i] + vals[i+1...vals.size]
    # The report is safe if both checks pass
    is_sorted(subset) and is_change_in_range(subset)
  end.any? true
end
```
