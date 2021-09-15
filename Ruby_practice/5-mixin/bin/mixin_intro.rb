# примесь
module Debug
    def self.hello
        puts 'hello'
    end
    
    def who_am_i? # Экземпляр метода
      "#{self.class.name} (id: #{self.object_id})"
    end
end
# Won't work: Debug.who_am_i?

class Test
    include Debug # Примешивание модуля Debug
end

class Abc
    include Debug
end

test = Test.new
puts test.who_am_i?

abc = Abc.new
puts abc.who_am_i?

# Error: Abc.hello