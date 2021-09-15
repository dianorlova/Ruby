data = [5, 66, 13, 24, 46]
# Все элементы с позицией
data.each_with_index do |number, index|
    puts "#{index}: #{number}"
end
# Все ли элементы удовлетворяют условию: являются нечётными
data.all? { |number| number.odd? }
# Создать новый массив на основе текущего: квадраты чисел
data.map { |number| number**2 }
# Посчитать общую характеристику: сумму чисел
data.reduce { |memo, number| number + memo }
# Выбрать часть элементов массива
data.select { |number| number > 40 }

puts "You gave  #{ARGV.size}  arguments"
p ARGV