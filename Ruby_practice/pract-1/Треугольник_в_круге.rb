# XXX/ Этот код необходим только при использовании русских букв на Windows
if (Gem.win_platform?)
    Encoding.default_external = Encoding.find(Encoding.locale_charmap)
    Encoding.default_internal = __ENCODING__
 
    [STDIN, STDOUT].each do |io|
      io.set_encoding(Encoding.default_external, Encoding.default_internal)
    end
end
# /XXX

puts "\nПриложение определяет, можно ли разместить треугольник со сторонами a,b,c в круге радиуса r."
puts "Введите три стороны треугольника a,b,c:"
print "a = "
a = gets.strip.to_f
print "b = "
b = gets.strip.to_f
print "c = "
c = gets.strip.to_f

if a+b<=c or b+c<=a or a+c<=b or a<=0 or b<=0 or c<=0
    puts "ERROR: треугольника с такими длинами сторон не существует!"
    return 0
end

puts "Введите радиус круга r:"
print "r = "
r = gets.strip.to_f

per = (a+b+c)/2 #полупериметр
s = Math.sqrt(per*(per-a)*(per-b)*(per-c)) # площадь треугольника
r2 = (a*b*c)/(4*s) #радиус круга вокруг треугольника

if r == r2
    puts "SUCCESS: Треугольник можно разместить в круге радиуса #{r}"
else 
    puts "ERROR: Треугольник нельзя разместить в круге радиуса #{r}"
end