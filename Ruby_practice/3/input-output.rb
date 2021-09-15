f = File.open('testfile')
# итератор для чтения по линиям
f.each do |line|
  puts "The line is:  #{line}"
end
f.close


# Учёт позиции в итераторе
f = File.open("testfile")
f.each.with_index do |line, index|
  puts "Line  #{index}  is:  #{line}"
end
f.close