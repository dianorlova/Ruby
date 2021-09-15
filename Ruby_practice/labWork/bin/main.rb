# frozen_string_literal: true
require 'csv'
require_relative '../lib/city'
require_relative '../lib/class_in_school'
require 'tty-prompt'

def general_act
city = City.new
city.read_in_csv_data(File.expand_path('../data/students.csv', __dir__))
return city
end

def menu(prompt,city)
yield
loop do
case prompt.ask('> №').to_i
when 1
act1(city)
when 2
act2(city)
when 3
puts "Программа успешно завершила свою работу."
break
else
puts "Некорректный выбор действия!"
end
yield
end
end

def act1(city)
sort_city = city.sort_by_school_class_date
sort_city.upload_to_csv(File.expand_path('../data/schools.csv', __dir__))
puts "Успешное выполнение"
end

def act2(city)
puts "Введите тип учебного заведения"
view = gets
puts "Введите номер"
num = gets
classes = city.select_school("Школа","118")
if !classes.empty?
Dir.mkdir(File.expand_path(('../data/' + "School" + "_" + num).chomp, __dir__))
d = Dir.new(File.expand_path(('../data/' + "School" + "_" + num).chomp, __dir__))
for c in classes.keys
class_in_sl = Class_in_school.new(classes[c])
class_in_sl.upload_to_csv(File.join(d, c))
end
puts "Успешное выполнение"
else
puts "Выбранного учебного заведения не существует"
end
end

def main

prompt = TTY::Prompt.new
city = general_act
menu(prompt,city) do
puts "\nПриложение позволяет обрабатывать список школьников города.\nВыберите действие №1, №2 или №3:"
puts "№1 - Сформировать общий список в файл.\n№2 - Сформировать список классов для школы.\n№3 - Завершить работу."
end

end

main if __FILE__ == $PROGRAM_NAME