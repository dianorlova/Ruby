# frozen_string_literal: true

require_relative 'auto'
require_relative 'fleet'

def main
    auto_new = Auto.new("Honda", "Civic", 1998, 12.5)
    # p auto_new
    # puts auto_new

    array_fleet = Fleet.new()
    array_fleet.add(auto_new)  # *Добавить автомобиль в список автомобилей.*
    
    # Данный метод добавит в массив автомобилей все автомобили, описанные в JSON-документе.
    array_fleet.load_from_file(File.expand_path('cars-list.json',__dir__))
    p array_fleet
    # p array_fleet.cars
    array_fleet.cars.each {|car| puts "\n#{car}"}  # выводит список автомобилей с их характеристиками

    puts "\n\nCредний расход бензина для всего автомобильного парка = #{array_fleet.average_consumption}"
    puts "Количество автомобилей определённой марки (BMW) = #{array_fleet.number_by_brand("BMW")}"
    puts "Количество автомобилей определённой модели (Civic) = #{array_fleet.number_by_model("Civic")}"
    puts "Средний расход бензина для определённой марки(BMW) автомобильного парка: #{array_fleet.consumption_by_brand("BMW")}"
    # array_fleet.consumption_by_brand.each_pair() do |brand, gasoline_consumption|
    #     puts "Brand: #{brand} Gasoline consumption: #{gasoline_consumption}"
    # end
end

main if __FILE__ == $PROGRAM_NAME 