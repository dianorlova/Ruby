def main
    file_text = read_txt_file(File.expand_path('data.txt',__dir__))
    words_array = text_to_words(file_text)
    # puts words_array
    # p words_array
    words_frequency = count_words(words_array)
    # p words_frequency
    top_words = fetch_top_words(words_frequency)
    print_words(top_words)
end

# читаем из файла
def read_txt_file(file_name)
    File.read(file_name)
end

# выделяем слова и помещаем в массив
def text_to_words(text)
    text.downcase.scan(/[\p{Alpha}']+/)  # возвращает массив строк в нижнем регистре, совпадающих с рег.выражением
end

# находим количество каждого слова
def count_words(words_array)
    # frequency = {}  # ассоциативный массив
    # words_array.each do |word|
    #     if frequency.key?(word)
    #         frequency[word] += 1
    #     else 
    #         frequency[word] = 1
    #     end
    # end
    frequency = Hash.new(0)  # ассоциатив. массив (Хеш) со значением по умолчанию
    words_array.each do |word|
        frequency[word] += 1
    end
    return frequency  # возвращает ассоциативный массив
end

# сортируем ассоц.массив по значением(количеству встречаемости)
def fetch_top_words(frequency)  # возвращает массив, состоящий из массивов, в которыз по 2 элемента
    frequency.sort_by do |word,count|
         count  # если сортировать в обратном порядке, то можно инвертировать ключ сортировки (-count)
    end.first(9)  # от результата(массив) возьмём только первые 9 эл-тов
end

# преобразуем в формат, понятный для человека
def print_words(words)
    puts "Наиболее часто встречающиеся слова:"
    words.each do |word,count|
        puts "#{word}: #{count}"
    end
end
main if __FILE__ == $PROGRAM_NAME
