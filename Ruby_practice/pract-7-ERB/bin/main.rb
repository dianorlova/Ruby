require 'yaml'
require 'erb'
require_relative '../lib/employees'
def main
   
    people = Employees.new
    people.read_file
    # p people['people'][0]['name']
    # puts people.employees
    # puts people
    # p people.employees

     # Описываем шаблон
     template = <<~TEMPLATE
     <!DOCTYPE html>
     <html>
     <head><title>Компания</title></head>
     <body>
       <h1>Информация по всем сотрудникам компании</h1>
       <p>Краткий список сотрудников</p>
       <ul>
         <% people.employees.each do |p| %>
           <li><b><%= p.name %> <%= p.surname %></b></li>
         <% end %>
       </ul>
     </body>
   </html>
     TEMPLATE
 
     # Создаём шаблонизатор и передаём ему шаблон для работы
    rhtml = ERB.new(template)

    # Формируем результат
    p people
    rhtml.run(people.get_binding(people))
end

main if __FILE__ == $PROGRAM_NAME