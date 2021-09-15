class Some
    def hello
        puts 'Hello'
    end

    # метод относится к классу, а не к его объекту
    def self.make_some
        Some.new
    end
end

some = Some.new
some.hello
# ERROR: some.make_some
puts Some.make_some  