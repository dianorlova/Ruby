# frozen_string_literal: true
# поззволяет разрешать или запрещать изменение строковых литералов

# if RUBY_PLATFORM.include?('mingw32')
#     Encoding.default_external = Encoding::CP866
# end

require_relative 'my_complex'

def main
    # real = gets.chomp
    # imaginary = gets.chomp
    # obj_zero = MyComplex.new(real,imaginary)

    obj_one = MyComplex.new(1,2)
    obj_two = MyComplex.new(3,5)

    # p obj_zero
    # puts obj_zero.real
    # puts obj_zero.imaginary

    p obj_one
    puts obj_one

    p obj_two
    puts obj_two

    puts "Операции над комплекс. числами"

    puts "Сложение"
    new_obj1 = obj_one.add(obj_two)
    p new_obj1
    puts new_obj1

    puts "Умножение"
    new_obj2 = obj_one.multiply(obj_two)
    p new_obj2
    puts new_obj2

    puts "Вычитание"
    new_obj3 = obj_one.sub(obj_two)
    p new_obj3
    puts new_obj3

end

main if __FILE__ == $PROGRAM_NAME 