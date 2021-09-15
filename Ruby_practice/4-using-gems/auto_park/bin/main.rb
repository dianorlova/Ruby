# frozen_string_literal: true


require_relative '../lib/auto'
require_relative '../lib/fleet'
require 'tty-prompt'
require 'chunky_png'

def main
  auto_new = Auto.new('Honda', 'Civic', 1998, 12.5)
  # p auto_new
  # puts auto_new
  prompt = TTY::Prompt.new

  array_fleet = Fleet.new
  array_fleet.add(auto_new)

  brand = prompt.ask("brand > ")
  model = prompt.ask("model > ")
  manifacture_year = prompt.ask("manifacture_year > ").to_i
  gasoline_consumption = prompt.ask("gasoline_consumption > ").to_f
  auto_new_with_prompt = Auto.new(brand,model,manifacture_year,gasoline_consumption)
  array_fleet.add(auto_new_with_prompt)

  array_fleet.load_from_file(File.expand_path('../data/cars-list.json', __dir__))
  # p array_fleet.cars
  array_fleet.cars.each { |car| puts "\n#{car}" }

  puts "\n\nCредний расход бензина для всего автомобильного парка = #{array_fleet.average_consumption}"
  puts "Количество автомобилей определённой марки (BMW) = #{array_fleet.number_by_brand('BMW')}"
  puts "Количество автомобилей определённой модели (Civic) = #{array_fleet.number_by_model('Civic')}"
  puts "Средний расход бензина для определённой марки(BMW) автомоб. парка: #{array_fleet.consumption_by_brand('BMW')}"
  # array_fleet.consumption_by_brand.each_pair() do |brand, gasoline_consumption|
  #     puts "Brand: #{brand} Gasoline consumption: #{gasoline_consumption}"
  # end

  png = ChunkyPNG::Image.new(1000, 500, ChunkyPNG::Color::WHITE)
  max_gasoline = array_fleet.cars.max_by{ |elem| elem.gasoline_consumption } # ищем маскимальное потребление топлива среди машин
  # puts max_gasoline
  png.rect(10, 490, 60, max_gasoline.gasoline_consumption.to_i - auto_new.gasoline_consumption.to_i, "black", "darkred")
  png.rect(70, 490, 120, max_gasoline.gasoline_consumption.to_i - auto_new_with_prompt.gasoline_consumption.to_i, "black", "darkblue")

  png.save('gasoline_gistogram.png', :interlace => true)

end

main if __FILE__ == $PROGRAM_NAME
