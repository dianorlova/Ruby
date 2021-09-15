array = (1..150).to_a
# array.each_slice(9){|sub_arr| p sub_arr.length}

enum = array.enum_for(:each_slice,56)
p enum.next  # первый элемент итератора (массив из 56 эл-тов)
p enum.next
p enum.next