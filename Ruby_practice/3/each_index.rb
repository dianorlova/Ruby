[6,7,8,7].each.with_index do |num,index|
    puts "#{index}: #{num}"
end


p [10,12,3,17,79].delete_if{|num| num**3>100}