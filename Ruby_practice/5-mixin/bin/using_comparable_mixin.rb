class SizeMatters
    include Comparable
    attr_reader :str

    def initialize(str)
        @str = str
    end

    def <=>(other)
      # =0 - Равны
      # >0 - Больше
      # <0 - Меньше
      str.size <=> other.str.size
    end
    
  end
  
  s1 = SizeMatters.new("Z")
  s2 = SizeMatters.new("YY")
  s3 = SizeMatters.new("XXX")
  s4 = SizeMatters.new("WWWW")
  s5 = SizeMatters.new("VVVVV")
  
  p s1 < s2                       #=> true
  p s4.between?(s1, s3)           #=> false
  p s4.between?(s3, s5)           #=> true
  p [ s3, s2, s5, s4, s1 ].sort   #=> [Z, YY, XXX, WWWW, VVVVV]