if RUBY_PLATFORM.include?('mingw32')
  Encoding.default_external = Encoding::CP866
end

puts "\nПриложение считывает слова, ведённые пользователем и подсчитывает сколько раз пользователь ввёл слово 'дерево'."
puts "Вводите по одному слову в строку!"

count = 0 # количество введённого слова 'дерево'

while true
  print "Введите слово> "
  str = gets
  if str.nil? or str.strip.encode('UTF-8') == "конец"
    puts "Количество введённого слова 'дерево' = #{count}"
    break
  end

  str = str.strip.encode('UTF-8') # убираем пробелы справа, слева и перевод строки

  if str == "дерево"
    count += 1
  end

end