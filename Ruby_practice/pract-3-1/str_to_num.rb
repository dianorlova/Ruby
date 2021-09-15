# преобразование строки в число (для использования в последующих задачах)

# Данный метод должен проверять введённые пользователем данные на корректность.
# Т.е. если пользователь ввёл пустую строку или ввёл не вещественное число, тогда метод должен сообщить пользователю о неправильном вводе данных.

def str_to_float(str)
    begin
        # if str.nil? or str.to_f.to_s != str
        #     return nil
        # else
        #     Float(str)
        # end
        return Float(str)
    rescue => exception
        return nil
    end
end


def str_to_int(str)
    begin
        num = Integer(str)
        if num.to_s==str
            return num
        else
            return nil
        end
    rescue => exception
        return nil
    end
end
