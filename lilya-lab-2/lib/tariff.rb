# frozen_string_literal: true

# tariff description
class Tariff
  attr_reader :tariff_name, :minute_price, :minutes_volume, :payment

  def initialize(tariff_name)
    @tariff_name = tariff_name
    case @tariff_name
    when 'Unlimited'
      @minutes_volume = nil
      @payment = 420.0
      @minute_price = 0
    when 'Combined'
      @minutes_volume = 350
      @payment = 300.0
      @minute_price = 0.34
    when 'Timed'
      @minutes_volume = 0
      @payment = 180.0
      @minute_price = 0.38
    end
  end

  def to_s
    @tariff_name
  end
end
