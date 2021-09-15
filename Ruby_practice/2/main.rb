# frozen_string_literal: true

# подключаем файл books.rb
require_relative 'books' # расширение не указываем

# точка входа
def main

    # создаём объект класса Books
    books = Books.new
    # p 'data.csv'
    # p File.expand_path('data.csv',__dir__)

    books.read_in_csv_data(File.expand_path('data.csv',__dir__)) # в скобках полный путь к файлу
    # p books
    puts "Общая стоимость книг: #{books.total_value_in_stock}"
    puts "Количество книг по ISBN"
    books.book_count_by_isbn.each_pair do |isbn, count|
        puts "#{isbn}: #{count}"
    # Выполняет блок block для каждого ключа в хеше, передавая в блок
    # ключ и значение в качестве параметров. 
    end
end

# метод main работает в том случае,
# если текущий файл(в котором мы находимся) является названием программы
main if __FILE__ == $PROGRAM_NAME 
