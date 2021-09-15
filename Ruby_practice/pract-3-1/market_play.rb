require_relative "str_to_num"

def main
    if ARGV.size == 0 or (ARGV.size == 1 and ARGV[0] == '--help')
        puts "Приложение эмитирует игру на рынке. Передайте стартовый капитал и количество дней в качестве аргументов приложения.\n"
        puts "market_game.rb CAPITAL DAYS\n"
        puts "CAPITAL - real number, >= 0"  # Объём изначальных инвестиций
        puts "DAYS - integer, >= 0"  # Сколько дней ждать до вывода остатка денежных средств
    elsif ARGV.size == 2
        capital = str_to_float(ARGV[0])
        days = str_to_int(ARGV[1])
        if capital.nil? or days.nil? or capital < 0 or days < 0
            puts "Переданы неправильные аргументы, обратитесь к справке (--help)"
        end

        # Каждый день на рынке происходит “игра”. В зависимости от случайного значения rand(15)
        for i in 1..days
            magic_num = rand(15)
            case magic_num
            when 15  # Больше 14 - повысьте счёт на 10%
                capital += 0.1 * capital
            when 13,14  # Больше 12 - повысьте счёт на 2%
                capital += 0.02 * capital
            when 10..12   # Больше 9 - оставьте счёт неизменным
                capital = capital
            when 8,9   # Больше 7 - отнимите со счёта 2%
                capital -= 0.02 * capital
            when 6,7   # Больше 5 - отнимите со счёта 10%
                capital -= 0.1 * capital

            else
                capital -= 0.5 * capital
            end
            
            # По окончании каждой игры приложение должно показать пользователю текущее состояние счёта.
            puts "Текущее состояние счёта: #{capital}"
        end
        puts "Состояние счёта после #{days} дней: #{capital} "
    else
        puts "Переданы неправильные аргументы, обратитесь к справке (--help)"
        
    end
end

main if __FILE__ == $PROGRAM_NAME