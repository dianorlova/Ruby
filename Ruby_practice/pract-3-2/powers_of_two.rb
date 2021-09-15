require_relative "str_to_num"

def main
    puts "\nПриложение печатает те элементы массива, индексы которых являются степенями двойки (1,2,4,8,16...)."
    print "\nВведите последовательность целых чисел: "
    arr = data_input_check()
    while arr.nil?
        puts "Упс! Вы ввели некорректные данные. Попробуйте ещё раз."
        print "\nВведите последовательность целых чисел: "
        arr = data_input_check()
    end

    p arr

    result = check_index_is_powers_of_two(arr)
    print "Элементы массива, индексы которых являются степенями двойки:"
    result.each {|i| print " #{i}"}
 
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

# возвращает массив элементов, индексы которых являются степенями двойки (1,2,4,8,16...)
def check_index_is_powers_of_two(arr)
    result = Array.new

    i = 1
    while i < arr.size
        if i <= arr.size
            result.append(arr[i])
        end
        i *= 2
    end

    return result
end

main if __FILE__ == $PROGRAM_NAME