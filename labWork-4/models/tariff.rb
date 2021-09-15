# frozen_string_literal: true

# Tariff
class Tariff
  attr_reader :tariff_name, :minute_price, :minutes_volume, :payment

  def initialize(tariff_name)
    @tariff_name = tariff_name
    case @tariff_name
    when 'Безлимитный'
      @minutes_volume = nil
      @payment = 420.0
      @minute_price = 0
    when 'Комбинированный'
      @minutes_volume = 350
      @payment = 300.0
      @minute_price = 0.34
    when 'Повременный'
      @minutes_volume = 0
      @payment = 180.0
      @minute_price = 0.38
    end
  end

  def self.tariff_id(id)
    case id
    when 1
      'Безлимитный'
    when 2
      'Комбинированный'
    when 3
      'Повременный'

    end
  end

  


  def to_s
    @tariff_name
  end
end
