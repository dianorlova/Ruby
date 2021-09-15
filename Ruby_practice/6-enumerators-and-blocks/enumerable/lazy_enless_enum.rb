numbers = Enumerator.new do |yielder|
    number = 0
    loop do
      number += 1
      yielder.yield number
    end
  end.lazy
  p numbers.select{|num| num.even?}.first(10)
  p numbers.select { |val|
       val % 10 == 0 }.first(5)
  p numbers.select { |val|
       (val % 3).zero? }.first(10)