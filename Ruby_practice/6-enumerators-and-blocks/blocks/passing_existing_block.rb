odd_filter = -> (value) do
    value.odd?
end


even_filter = -> (value) do
    value.even?
end

p even_filter.call(11)

filter = even_filter

# ассоциируем с select уже существующий блок filter
p [1,537,5,57,656,57].select(&filter)