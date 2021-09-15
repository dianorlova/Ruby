# frozen_string_literal: true

# class describes the essence of the car
class Auto
  attr_reader :brand, :model, :manifacture_year, :gasoline_consumption

  def initialize(brand, model, manifacture_year, gasoline_consumption)
    @brand = brand
    @model = model
    @manifacture_year = manifacture_year.to_i
    @gasoline_consumption = gasoline_consumption.to_f
  end

  def to_s
    "Марка: #{@brand}
    Модель: #{@model}
    Год выпуска: #{@manifacture_year}
    Средний расход бензина на 100 километров: #{@gasoline_consumption}"
  end
end
