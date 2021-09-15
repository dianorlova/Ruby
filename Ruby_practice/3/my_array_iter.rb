# Возващение значения из блока
class MyArray
    def initialize(arr)
        @arr=arr
    end

    def find # Вариант реализации find
        # обход массива и нахождение эл-та, удовлетворяющего методу find с его условием
      @arr.each do |value|
        return value if yield(value)
      end
      return nil
    end
  end


my_array = MyArray.new([1, 3, 5, 7, 9])
p my_array.find {|v| v**2 > 30} # => 7
# Если блок возвращает правдивое значение, тогда #find возвращает значение элемента
# Метод #find ничего не знает об условии, но эффективно обходит все элементы массива и предоставляет общую структуру для решения задачи