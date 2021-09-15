# frozen_string_literal: true

require 'csv'  # подключаем библиотеку csv
require_relative 'book_in_stock'  # подключаем файл который описывает книгу

# require 'pry'  # добавляем для отладки библиотеку
class Books  # класс для работы с набором книг
    def initialize
      @books = []
    end

    # наполнение books
    def read_in_csv_data(file_name)
        # чтение данных из CSV-файла
        # это итератор, который позволяет
        # пройтись по всем строкам и вывести инфу по каждой из них
        CSV.foreach(file_name, headers: true) do |row|
            # binding.pry  # хотим исследовать работу прилож-я
            # создадим объекты класса BookInStock
            book = BookInStock.new(row['ISBN'],row['Price'])  # каждой книге передадим isbn и цену
            @books.append(book)

            # p row
            # p row[0]
            # p row['ISBN']
        end
    end

    # общая стоимость всех книг, которые у нас есть
    def total_value_in_stock
        # метод reduce обходитвесь массив и собирает какую-то характеристику, начальное значение ставим 0.0
        @books.reduce(0.0){|sum,book| sum+book.price}
    end

    # количество книг по isbn
    def book_count_by_isbn
        isbn_hash = Hash.new(0)  # ассоциативный массив со значением по умолчанию
        # базовый итератор чтобы построить соотв. хеш
        @books.each do |book|
            isbn_hash[book.isbn] += 1
        end
        isbn_hash  #return не пишем (последняя строчка)
    end

end