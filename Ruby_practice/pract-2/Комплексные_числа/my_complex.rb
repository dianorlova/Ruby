# frozen_string_literal: true
# поззволяет разрешать или запрещать изменение строковых литералов

class MyComplex

    # описание атрибутов на чтение
    attr_reader :real
    attr_reader :imaginary


    # метод для установки значений переменным экземпляра класса
    def initialize(real,imaginary)
        @real = Float(real)
        @imaginary = Float(imaginary)
    end

    def to_s
        return "#{@real} + i * #{@imaginary}"
    end

    # сложение
    def add(other)
        real_new = @real + other.real
        imaginary_new = @imaginary + other.imaginary
        new_obj = MyComplex.new(real_new,imaginary_new)
        return new_obj
    end

    # умножение
    def multiply(other)
        real_new = @real*other.real - @imaginary*other.imaginary
        imaginary_new = @real*other.imaginary + other.real*@imaginary
        new_obj = MyComplex.new(real_new,imaginary_new)
        return new_obj
    end

    # вычитание
    def sub(other)
        real_new = @real - other.real
        imaginary_new = @imaginary - other.imaginary
        new_obj = MyComplex.new(real_new,imaginary_new)
        return new_obj
    end

    
end