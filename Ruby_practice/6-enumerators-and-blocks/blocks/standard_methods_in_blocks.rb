res = [1,4,5,6].map do |num|
    num.to_s
end


p res


res_two = [1,4,5,6].map(&:to_s)

p res_two


to_s_proc = :to_s.to_proc
p to_s_proc.call(11)