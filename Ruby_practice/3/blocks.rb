sum = 0
[1, 2, 3, 4].each do |value|
  square = value * value
  puts square
  sum += square
end
puts sum

# лучше так не делать!
# value = "some shape"
# [1, 2].each {|value| 
#     puts value}  # внешняя переменная value будет замаскирована
# puts value