
def find_digits(word)
  [word[/\d/], word.reverse[/\d/]]
end

def calibration_value(word)
  find_digits(word).join('').to_i
end

total = 0

f = File.new("01-input.txt")
f.each_line {|line| total += calibration_value line}
f.close

puts total
