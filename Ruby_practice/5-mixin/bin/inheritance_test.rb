# Simple class
class Parent
    def hello
        puts "Hello #{self}"
    end
end

# Simple child class
class Child < Parent
    
end

parent = Parent.new
parent.hello

child = Child.new
child.hello

p child.class #Child
p child.class.superclass #Parent
p child.class.superclass.superclass #Object
p child.class.superclass.superclass.superclass #BasicObject
p child.class.superclass.superclass.superclass.superclass #nil