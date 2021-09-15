class VowelFinder
    include Enumerable
    def initialize(string)
        @string = string
    end

    # метод каждую гласную букву из строки передаст в блок, с которым связан этот метод
    def each
        @string.scan(/[aoeuyi]/) do |vowel|
            yield vowel
        end
    end
end

finder = VowelFinder.new('Money for nothing')
#  блок после each переходит как бы в yield в функцию
finder.each do |vowel|
    puts vowel
end

puts (finder.any?{|vowel|vowel=='y'} )
p (finder.map{|vowel|vowel.upcase})
p (finder.sort)