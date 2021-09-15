# frozen_string_literal: true

require 'json'
require_relative 'auto'
# class describes the essence of the auto park
class Fleet
  attr_reader :cars

  def initialize
    @cars = []
  end

  def add(other_auto)
    @cars.append(other_auto)
  end

  def load_from_file(file_name)
    json_data = File.read(file_name)
    ruby_objects = JSON.parse(json_data)

    ruby_objects.each do |obj|
      car = Auto.new(obj['mark'], obj['model'], obj['year'], obj['consumption'])
      @cars.append(car)
    end
  end

  def average_consumption
    a = @cars.inject(0.0) { |sum, elem| sum + elem.gasoline_consumption }
    b = @cars.size
    a / b
  end

  def number_by_brand(brand_other)
    @cars.select do |car|
      car.brand == brand_other
    end.size
  end

  def number_by_model(model_other)
    @cars.select { |car| car.model == model_other }.size
  end

  def consumption_by_brand(brand_other)
    a = @cars.select { |car| car.brand == brand_other }
    b = a.inject(0) { |sum, elem| sum + elem.gasoline_consumption }
    c = a.size
    b / c
    # consumption_hash = Hash.new(0)
    # @cars.each() do |car|
    #     consumption_hash[car.brand] = car.gasoline_consumption
    # end
    # return consumption_hash
  end
end
