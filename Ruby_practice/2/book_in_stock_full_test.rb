# frozen_string_literal: true
# поззволяет разрешать или запрещать изменение строковых литералов

class BookInStockFullTest

    attr_accessor :isbn
    attr_reader :price


    def initialize(isbn,price)
        @isbn = isbn
        @price = price
    end

    def to_s
        "ISBN: #{@isbn}, price: #{@price}"
    end

    ## вместо них используем attr_reader(читает)
    # def isbn
    #     @isbn  # значение переменной экземпляра
    # end

    # def price
    #     @price
    # end

    ## вместо этого использовать можно attr_accessor(читает и записывает новое значение)
    # метод записи значений в переменную экземпляра
    # def isbn=(isbn)
    #     @isbn=isbn
        
    # end

    # Виртуал. атрибут - стоимость книги в копейках
    def price_in_copecks
        # число в копейках всегда будет целым(+0.5 для правильного округления)
        Integer(@price*100+0.5)
    end
    
    # метод для записи нового значения в копейках
    def price_in_copecks=(copecks)
        @price=copecks/100.0
    end



end

book_one = BookInStock.new('isbn-1', 1155.5)
book_two = BookInStock.new('isbn-2', 1253.5)

pp book_one
# puts book_one  # в методе puts приводит к строке с помощью to_s, описанного выше
puts book_one.isbn
book_one.isbn = 'isbn-3'  #изменили значение переменной экземпляра класса
pp book_one
# puts book_one.price

puts book_two.price_in_copecks  # считаем эту цену в копейках
book_two.price_in_copecks = 10527  # записывается НОВАЯ стоимость в копейках
pp book_two

# pp book_two
# puts book_two
