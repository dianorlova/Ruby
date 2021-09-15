short = [1, 2, 3].to_enum
# short = 1.upto(5)
long = ('a'..'z').to_enum
loop do
  puts " #{short.next} - #{long.next}"
end

short.next