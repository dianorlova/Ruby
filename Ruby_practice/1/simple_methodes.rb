def say_goodnight(name)
    # result = "Good night, " + name #(1)
    result = "Good night, #{name}" #(2)
    return result
    # отсюда также можно убрать result и return
end

# Вызываем метод
puts say_goodnight("John-Boy")
puts say_goodnight("Mary-Ellen")
# Не будет работать!(строка складывается с числом) - (1)
puts say_goodnight(42) #при (2) работает