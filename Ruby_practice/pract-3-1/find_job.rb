def main
    if RUBY_PLATFORM.include?('mingw32')
        Encoding.default_external = Encoding::CP866
    end

    if ARGV.size == 0 or (ARGV.size == 1 and ARGV[0] == '--help')
        puts "\n\nПриложение подбирает работу для вас на основании введённых данных\n"
        puts "find_job.rb --name=NAME --surname=SURNAME --mail=MAIL --age=AGE --experience=EXPERIENCE"
    end
    
    # ARGV.each do |elem|
    #     puts elem
    # end

    hash_data = read_data(ARGV)

    res = job_selection(hash_data)
    puts res

end

def read_data(arr_data)
    hash_data = Hash.new
    arr_data.each do |str|
        if str.start_with?("--name=")
            hash_data["--name="] = str[7..(str.length)]
        elsif str.start_with?("--surname=")
            hash_data["--surname="] = str[10..(str.length)]
        elsif str.start_with?("--age=")
            hash_data["--age="] = str[6..(str.length)].to_i
        elsif str.start_with?("--mail=")
            hash_data["--mail="] = str[7..(str.length)]
        elsif str.start_with?("--experience=")
            hash_data["--experience="] = str[13..(str.length)].to_i
        end

    end
    return hash_data
end

def job_selection( hash_data)
    profession = Array.new

    profession.append("Руководитель") if hash_data["--name="]=="Пётр" and hash_data["--surname="]=="Петрович"
    profession.append("Инженер") if hash_data["--mail="].include?("code")
    profession.append("Стажёр") if hash_data["--experience="] < 2
    profession.append("Бывалый") if hash_data["--age="] > 40 and hash_data["--age="] < 60
    profession = profession.map {|prof| "Заслуженный " + prof} if hash_data["--experience="] > 15
    profession = profession.map {|prof| "Известный " + prof} if hash_data["--experience="] > 5
    return profession
end

main if __FILE__ == $PROGRAM_NAME