# 2024 Day 2

Our goal:

- Our parsing logic is the same as in [day 1](../01/README.md).
- We also need to count the incoming values. A Hash is a simple way of doing
  this.
- Sorting isn't required anymore.
- Similarity score is determined from `value * <occurrences of value in other list>`

## Extra Data

I created a new class to OOP-ify the list and the hash that I need. In thinking
about this, there's probably a way to get cheeky and do this only with a Hash,
but it's probably not a huge savings.

A default value set on the Hash helps simplify code.

## Similarity Score

Grab each value from the `left` side and multiply it by the number of
occurrences of that value in `right`. We'll use the Hash to grab that data. We
can roll this into the `ColumnFindings` class to simplify the code a bit.

```ruby
def ColumnFindings
  attr_accessor :counts
  
  def similarity_score_of(val)
    val * @counts[val]
  end
end
```
