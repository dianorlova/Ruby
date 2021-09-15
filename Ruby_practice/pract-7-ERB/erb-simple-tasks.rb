require 'erb'


def erb_hello(name)
  puts ERB.new("Привет, <%= name %>!\n\n").result(binding)
end

def str_hello(name)
  puts "Привет, #{name}!"
end
# erb_hello('Дианочка')
# str_hello('Дианочка')

def erb_create_invitation(event_title,name,text,sender)
  template = "
  Дорогая <%= name %>, ты приглашена на <%= event_title %>
  <%= text %>
  Твои друзья, <%= sender %>\n\n"
  puts ERB.new(template).result(binding)
end

def str_create_invitation(event_title,name,text,sender)
  puts "Уважаемая #{name}, #{text} #{event_title}!\nОтправитель: #{sender}"
end
# str_create_invitation("\"Выставка кошек\"","Диана","приглашаем вас на увлекательное мероприятие","Кошачий комитет")
# erb_create_invitation("\"Выставка кошек\"","Диана","Ждём с нетерпением!","Кошачий комитет")


def erb_product_description(product_name,cost,category)
  template = "
  <% if category == :dress %>
  Купите замечательное платье!
  <% elsif category == :shoes %>
  Купите замечательную обувь!
  <% elsif category == :tools %>
  Купите замечательные инструменты!
  <% end %>
  Название: <%= product_name %>\n
  Цена: <%= cost %>\n\n"
  puts ERB.new(template).result(binding)
end

def str_product_description(product_name,cost,category)
  if category == :dress
    puts "Купите замечательное платье!"
  elsif category == :shoes
    puts "Купите замечательные туфли!"
  elsif category == :tools
    puts "Купите замечательные украшения!"
  else puts "Такого товара нет в нашем интернет-магазине!"
  end
  puts "Название: #{product_name}"
  puts "Цена: #{cost} руб."
end

# str_product_description("Befree",2000,:shoes)
# erb_product_description("Befree",2000,:dress)

def time_table
  schedule = [
      {name: "Теормех", audience: 112, when: :numerator},
      {name: "Мат. ан.", audience: 205},
      {name: "Теор. игр", audience: 108},
      {name: "Ин. яз.", audience: 507, when: :denomitanor},
  ]
  schedule
end

def get_timetable(table, weak)
  message = "Расписание на неделю:
  <% table.each do |subject| %>
  <% if subject[:when] == nil || subject[:when] == weak %> <%=subject[:name]%> <%= subject[:audience]%> <% end %> <% end %>"
  puts ERB.new(message).result(binding)
end

# get_timetable(time_table, :numerator)