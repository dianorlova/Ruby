# frozen_string_literal: true

# Subscriber
class Subscriber
  attr_reader :surname, :name, :telephone, :tariff, :minutes

  def initialize(surname, name, telephone, tariff, minutes)
    @surname = surname
    @name = name
    @telephone = telephone
    @tariff = Tariff.new(tariff)
    @minutes = Float(minutes)
  end

  def tariff_type
    @tariff.tariff_name
  end

  def payment_for_last_month
    case @tariff.tariff_name
    when 'Безлимитный'
      cost = @tariff.payment
    when 'Комбинированный'
      cost = @tariff.payment
      if @minutes > @tariff.minutes_volume
        cost += (@minutes - @tariff.minutes_volume) * @tariff.minute_price
      end
    when 'Повременный'
      cost = @tariff.payment
      if minutes > @tariff.minutes_volume
        cost += (minutes - @tariff.minutes_volume) * @tariff.minute_price
      end
    end
    cost
  end

  def payment_for_last_month_other_tariff(tariff_obj)
    # tariff_obj = Tariff.new(tariff_name)
    case tariff_obj.tariff_name
    when 'Безлимитный'
      cost = tariff_obj.payment
    when 'Комбинированный'
      cost = tariff_obj.payment
      if @minutes > tariff_obj.minutes_volume
        cost += (@minutes - tariff_obj.minutes_volume) * tariff_obj.minute_price
      end
    when 'Повременный'
      cost = tariff_obj.payment
      if minutes > tariff_obj.minutes_volume
        cost += (minutes - tariff_obj.minutes_volume) * tariff_obj.minute_price
      end
    end
    cost
  end

  def profit_tariff
    tariffs = [Tariff.new('Безлимитный'),
               Tariff.new('Комбинированный'),
               Tariff.new('Повременный')]
    min_tariff = @tariff
    # p min_tariff
    # p payment_for_last_month
    # p payment_for_last_month_other_tariff(tariff)
    tariffs.each do |tariff|
      min_tariff = tariff if payment_for_last_month > payment_for_last_month_other_tariff(tariff)
    end
    if @tariff.tariff_name == min_tariff.tariff_name
      nil
    else
      min_tariff
    end
  end

  def to_s
    "#{@name},#{@surname},#{@telephone},#{@tariff},#{@minutes}\n"
  end
end
