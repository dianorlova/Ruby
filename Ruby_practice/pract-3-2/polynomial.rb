require_relative "str_to_num"

def main
    puts "\nПриложение  вычисляет значение этого многочлена в точке x. Также вычисляет значение его производной в той же точке."
    print "\nВведите последовательность коэффициентов многочлена a_n, a_n-1, ..., a_0: "

    arr = data_input_check(Array.new(gets.strip().split(' ')))
    while arr.nil?
        puts "Упс! Вы ввели некорректные данные. Попробуйте ещё раз."
        print "Введите последовательность коэффициентов многочлена a_n, a_n-1, ..., a_0: "
        arr = data_input_check(Array.new(gets.strip().split(' ')))
    end

    p arr

    print "\nВведите точку x: "
    x = x_check(gets.strip())
    # p x
    while x.nil?
        puts "Упс! Вы ввели некорректные данные. Попробуйте ещё раз."
        print "Введите точку x: "
        x = x_check(gets.strip())
    end

    result1 = value_of_polynomial(arr,x)
    puts "Значение многочлена = #{result1} в точке x = #{x}"

    result2 = value_of_derivative_of_polynomial(arr,x)
    puts "Значение производной многочлена = #{result2} в точке x = #{x}"

end



# ввод данных от пользователя + их проверка (что это целое число)
def data_input_check(arr)
    arr.each do |num|
        next num if (value = str_to_int(num)) != nil  # пропускаем то, что удовлетворяет усл-ю
        return nil  # если допущена ошибка при вводе, то возвращаем nul и сообщаем об ошибке(в main)
    end
    return result = arr.map {|num| num.to_i}  # если всё окей, то возвращаем массив из коэффициентов многочлена a_n, a_n-1, ..., a_0
end

def x_check(x)
    if str_to_int(x).nil?
        return nil
    else
        return str_to_int(x)
    end

end

# посчитаем значение многочлена в точке по схеме Горнера:  (((0*x + a3)x + a2)x + a1)x + a0
def value_of_polynomial(arr,x)
    if x == 0
        return arr[-1]
    end
    res = 0
    for i in 0..(arr.size-1) do
        res = res*x + arr[i]
    end
    return res
end

def value_of_derivative_of_polynomial(arr,x)
    res = 0
    if x == 0
        return res
    end
    for i in 0..(arr.size-2) do
        res = res*x + arr[i+1]*(i+1)  # вычисление производной по схеме Горнера
    end
    return res
end

main if __FILE__ == $PROGRAM_NAME