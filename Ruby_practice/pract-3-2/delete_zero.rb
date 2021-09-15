require_relative "str_to_num"

def main
    puts "\nПриложение уплотняет массив чисел, удалив нули и сдвинув влево остальные элементы."
    print "\nВведите последовательность целых чисел: "
    arr = data_input_check()
    while arr.nil?
        puts "Упс! Вы ввели некорректные данные. Попробуйте ещё раз."
        print "\nВведите последовательность целых чисел: "
        arr = data_input_check()
    end

    p arr
    result = delete_zero(arr)
    p result

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

# удаляем нули и сдвигаем эл-ты влево все элементы
def delete_zero(arr)
    arr.delete_if{|num| num == 0 }
    return arr
end

main if __FILE__ == $PROGRAM_NAME