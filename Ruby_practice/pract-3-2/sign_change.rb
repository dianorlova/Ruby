require_relative "str_to_num"

def main
    puts "\nПриложение определяет, сколько раз в последовательности из целых чисел меняется знак, а также номера позиций, в которых происходит смена знака."
    print "\nВведите последовательность целых чисел: "
    arr = data_input_check()
    while arr.nil?
        puts "Упс! Вы ввели некорректные данные. Попробуйте ещё раз."
        print "\nВведите последовательность целых чисел: "
        arr = data_input_check()
    end
    # p arr
    arr_index = count_of_sign_changes(arr)
    # puts "#{arr_index}"
    print "Знак в последовательности сменился #{arr_index.size} раз(a), в позициях:"
    arr_index.each {|i| print " #{i}"}
end

# ввод данных от пользователя + их проверка (что это целое число)
def data_input_check
    arr = Array.new(gets.strip().split(' '))
    arr.each do |num|
        next num if (value = str_to_int(num)) != nil  # пропускаем то, что удовлетворяет усл-ю
        return nil  # если допущена ошибка при вводе, то возвращаем nul и сообщаем об ошибке(в main)
    end
    return result = arr.map {|num| num.to_i}  # если всё окей, то возвращаем массив из целых чисел
end

# посчитает количество смен знака (знак меняется, если произведение отрицательное)
def count_of_sign_changes(arr)
    arr_index = Array.new
    num1 = arr.shift()  # извлекаем первый элемент
    arr.each_with_index do |num2,index|
        if num1 == 0
            num1 = num2
            next num2
        elsif num2 == 0
            next num2
        elsif num1*num2 < 0
            arr_index.append(index+1)   # +1, т.к. заранее извлекли первый элемент массива
            # puts "#{index+1}: #{num2}"
            num1 = num2
        end
    end
    return arr_index  # возвращаем массив, хранящий в себе индексы, в которых произошла смена знака
end

main if __FILE__ == $PROGRAM_NAME