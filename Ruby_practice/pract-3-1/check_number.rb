require_relative "str_to_num"  # подключаем файл с проверкой на ввод и преобразованием строки в число


def main
  if ARGV.size==0 or (ARGV.size==1 and ARGV[0]=='--help')
    puts "Данное приложение производит проверку числа. Передайте число в качестве первого аргумента приложения.\n"
    puts "check_number.rb NUMBER\n\n"
  elsif ARGV.size==1 and !((num=str_to_float(ARGV[0])).nil?)
    if num > 0
      puts "Число #{ARGV[0]} положительное."
    elsif num < 0
      puts "Число #{ARGV[0]} не положительное, а отрицательное."
    else
      puts "Непонятное число #{ARGV[0]}"
    end
  else
    puts "Переданы неправильные аргументы, обратитесь к справке (--help)"
    # puts "#{ARGV[0]}-#{ARGV[1]}" # для себя
  end
end



main if __FILE__ == $PROGRAM_NAME