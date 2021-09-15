# Класс для предоставления данных в шаблон
class Employee
    attr_reader :name,:patronymic,:surname,:email,:avatar
    def initialize(name,patronymic,surname,email,avatar)
        @name = name
        @patronymic = patronymic
        @surname = surname
        @email = email
        @avatar = avatar
    end

    # Получение доступа к контексту объекта
    def get_binding
        binding
    end
    
end