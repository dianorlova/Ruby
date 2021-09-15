

# print "Введите данные: "
# data = gets.strip
# # pp data
# # pp data.encoding
# puts "Read the data: #{data}"

# converted_data = data.encode('UTF-8') #encode можно не использовать
# # pp converted_data
# # pp converted_data.encoding
# puts "Converted data: #{converted_data}"

# frozen_string_literal: true

print 'Введие строку: '
data = gets
p data.encoding
p Encoding.default_external
p data
puts data

p RUBY_PLATFORM

if RUBY_PLATFORM.include?('mingw32')
  Encoding.default_external = Encoding::CP866
end

print 'Введите строку: '
data = gets
p data.encoding
p Encoding.default_external
p data
puts data