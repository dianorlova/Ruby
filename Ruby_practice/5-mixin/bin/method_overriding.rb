# Simple class
class Parent
    def hello
        puts "HELLO #{self}"
    end

    def to_s
        'parent'
    end
end

# Simple child class
class Child < Parent
    def hello
        super # Calling hello from the Parent class
        puts "Hello from the Child"
        super # Calling hello from the Parent class
    end
    def to_s
        'child'
    end
end

# This class has broken implementation of the hello
class BrokenChild < Parent
    def hello(name)
        puts "Hello,#{name}"
    end
end

parent = Parent.new
child = Child.new
parent.hello
child.hello

# @param object Parent] the obgect to call method on
def call_hello(obj)
    obj.hello
end

broken_child = BrokenChild.new
broken_child.hello("Alla")

puts parent
puts child

call_hello(parent)
call_hello(child)
call_hello(broken_child)