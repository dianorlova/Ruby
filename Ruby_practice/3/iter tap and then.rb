(1..10).tap {|x| puts "original: #{x}" }
  .to_a.tap {|x| puts "array: #{x}" }

"my string".then {|s| s.upcase } #=> "MY STRING"
3.next.then {|x| x**x }.to_s  #=> "256"

p 3.next

p 4**4