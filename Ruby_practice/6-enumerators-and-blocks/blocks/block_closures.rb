def f(thing)
    lambda {|times| thing * times }
end
p1 = f(23)
p1.call(3) # => 69
p1.call(2) # => 46

fourty_two = f(42)
p fourty_two
p fourty_two.call(2)
p fourty_two.call(5)