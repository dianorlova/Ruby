numbers = Enumerator.new do |yielder|
    number = 0
    count = 1
    loop do
      number += count
      count += 1
      yielder.yield number
    end
  end
5.times { print numbers.next, " " }
p numbers.first(8) # Доступны методы Enumerable