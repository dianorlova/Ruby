lam_one = lambda do |param1,param2|
    puts "You call with '#{param1}'"
end

lam_one.call('Some','one')

lam_two = -> (param1,param2) do
    puts "You call with '#{param1}'"
end

lam_two.call('Some','one')

# не контролирует кол-вл эл-тов, которые ожидает блок, А лямбда проверяет кол-во аргументов
proc_one = Proc.new do |param1,param2|
    puts "You called proc with param '#{param1}'"
end

proc_one.call('Some','one')