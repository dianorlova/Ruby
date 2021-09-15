# frozen_string_literal: true

# one line from the file | one subscriber
class Subscriber
  attr_reader :surname, :name, :phone_num, :tariff, :minutes

  def initialize(surname, name, phone_num, tariff, minutes)
    @surname = surname.strip
    @name = name.strip
    @phone_num = phone_num
    @tariff = Tariff.new(tariff)
    @minutes = Float(minutes)
  end

  def calculate_payment
    return @tariff.monthly_fee if @tariff.minutes_volume.nil? || @minutes <= @tariff.minutes_volume

    @tariff.monthly_fee + (@minutes - @tariff.minutes_volume) * @tariff.minute_price
  end

  def calculate_payment_other(tariff)
    return tariff.monthly_fee if tariff.minutes_volume.nil? || @minutes <= tariff.minutes_volume

    tariff.monthly_fee + (@minutes - tariff.minutes_volume) * tariff.minute_price
  end

  def profitable_tariff
    tariffs = [Tariff.new('Unlimited'),
               Tariff.new('Combined'),
               Tariff.new('Time-based')]
    min_tariff = @tariff
    tariffs.each do |t|
      min_tariff = t if calculate_payment > calculate_payment_other(t)
    end
    if @tariff.tariff_name == min_tariff.tariff_name
      nil
    else
      min_tariff
    end
  end

  def to_csv_row
    "#{@name};#{@surname};#{@phone_num};#{@tariff};#{@minutes}\n"
  end
end
