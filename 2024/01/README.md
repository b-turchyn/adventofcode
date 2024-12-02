# 2024 Day 1

Our goal:

- Each line of the file contains two data points. Split each line in half and
  add the entries to two separate lists.
- Sort each of those lists.
- Sum up the differences between the values in each index of the lists.

## Splitting

A regular expression makes quick work of this:

```ruby
# No error correcting being done here
l = /(\d+)\s+(\d+)/.match(line)
```

Alternatively we could split on whitespace via `\s+` if we needed to extend
this out to multiple columns of data.

## Sorting

An easy sort-in-place:

```ruby
left.sort!
right.sort!
```

## Diffing

[Array#each_index](https://docs.ruby-lang.org/en/master/Array.html#method-i-each_index)
lets us iterate over each index. Since the lists have the same number of items
we can safely do this.

We can subtract one value from the other, then `#abs` the result.

```ruby
result = 0
left.each_index {|i| result += (left[i] - right[i]).abs }
```
