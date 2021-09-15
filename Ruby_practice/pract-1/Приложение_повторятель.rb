if RUBY_PLATFORM.include?('mingw32')
    Encoding.default_external = Encoding::CP866
end

puts "\nПриложение-повторятель: повторяет предложения, введённые пользователем."

while true
    print "> "
    line = gets
    if line.nil? or line.chomp == "stop, please"
        break
    end
    puts line
    print line
    p line
end