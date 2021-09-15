# frozen_string_literal: true

require 'json'
require_relative 'auto'

class Fleet

    attr_reader :cars

    # Инициализатор не принимает никаких аргументов, но инициализирует переменную экземпляра @cars с пустым массивом.
    def initialize
        @cars = []
    end

    # Метод add принимает объекты типа Auto, которые добавляются в конец массива
    def add(other_auto)
        @cars.append(other_auto)
    end

    # Метод load_from_file принимает в качестве аргумента путь к JSON-документу.
    # Данный метод должен добавлять в массив автомобилей все автомобили, описанные в JSON-документе.
    # Для считывания JSON-документа вам потребуется сначала считать содержимое файла с помощью метода File::read,
    # а затем преобразовать считанную строку в объекты на языке Ruby с помощью библиотеки json и метода JSON::parse в частности.
    def load_from_file(file_name)

        # *Считать список автомобилей из JSON-документа.*
        json_data = File.read(file_name)  # считать содержимое файла
        ruby_objects = JSON.parse(json_data) # преобразовать считанную строку в ХЭШ массив из объектов // Конвертируем JSON-объект в хэш руби

        # puts ruby_objects

        ruby_objects.each() do |obj|
            car = Auto.new(obj["mark"],obj["model"],obj["year"],obj["consumption"])
            @cars.append(car)
        end
        
    end

    # Метод average_consumption подсчитывает средний расход бензина у всех известных автомобилей и возвращает полученное число.
    # Нельзя печатать данные на стандартный поток вывода!
    # *Подсчитать средний расход бензина для всего автомобильного парка.*
    def average_consumption
        a = @cars.inject(0.0){|sum, elem| sum + elem.gasoline_consumption}
        b = @cars.size
        return a/b
    end

    # Метод number_by_brand принимает в качестве аргумента бренд автомобиля по которому происходит поиск подходящих объектов.
    # Метод возвращает количество найденных автомобилей. Нельзя печатать данные на стандартный поток вывода!
    # *Найти количество автомобилей определённой марки.*
    def number_by_brand(brand_other)
        return @cars.select{|car| car.brand == brand_other}.size  # итератор select выбирает часть эл-тов массива, удовл. условию
    end

    # Метод number_by_model принимает в качестве аргумента модель автомобиля по которому происходит поиск подходящих объектов.
    # Метод возвращает количество найденных автомобилей. Нельзя печатать данные на стандартный поток вывода!
    # *Найти количество автомобилей определённой модели.*
    def number_by_model (model_other)
        return @cars.select{|car| car.model == model_other}.size
    end

    # Метод consumption_by_brand принимает в качестве аргумента бренд автомобиля по которому происходит поиск подходящих объектов.
    # Метод возвращает среднее потребление бензина для найденных объектов. Нельзя печатать данные на стандартный поток вывода!
    # *Найти средний расход бензина для каждой марки автомобильного парка.*
    def consumption_by_brand(brand_other)
        a = @cars.select{|car| car.brand == brand_other}  # выбрали машины с определённым брендом
        b = a.inject(0){|sum, elem| sum + elem.gasoline_consumption}  # складываем потребл-е бензина данных машин
        c = a.size  # нашли количество машин с определённым брендом
        return (b)/(c)
        # consumption_hash = Hash.new(0)  # ассоциативный массив со значением по умолчанию
        # @cars.each() do |car|
        #     consumption_hash[car.brand] = car.gasoline_consumption
        # end
        # return consumption_hash
    end
end