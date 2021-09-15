# frozen_string_literal: true

require 'csv'
require_relative './subscriber'

# list of subscribers
class SubscriberList
  def initialize
    @list = []
    # нужно было для автоматического создания номеров
    @numbers = []
    @next_num = 100_000
  end

  def read_in_csv(filename)
    CSV.foreach(filename, headers: true, col_sep: ';') do |row|
      @list.append(Subscriber.new(row['surname'], row['name'], Integer(row['phone_num']),
                                  row['tariff'], row['minutes']))
      @numbers.append(Integer(row['phone_num']))
    end
  end

  # попробуй придумать другой алгоритм раздачи номеров, например пользователь вводит сам
  def add(surname, name, tariff)
    if @numbers.size >= 900_000
      print('больше нет номеров')
      return nil
    end
    num = @next_num
    @next_num += 1
    @next_num += 1 while @numbers.include?(@next_num)
    @next_num = 100_000 if @next_num > 999_999
    subscriber = Subscriber.new(surname, name, num, tariff, '0')
    @list.push(subscriber)
    @numbers.push(num)
  end

  def delete(number)
    @list.delete_if { |subscriber| subscriber.phone_num == number }
    @numbers.delete_if { |num| num == number }
  end

  def find_for_number(number)
    @list.detect { |i| i.phone_num == number }
  end

  def find_for_surname(surname)
    @list.detect { |i| i.surname == surname }
  end

  def count_all
    @list.size
  end

  def count_tariff(tariff)
    @list.select { |i| i.tariff.tariff_name == tariff }.size
  end

  def average_cost
    if count_all.zero?
      0
    else
      @list.sum(&:calculate_payment) / count_all
    end
  end

  def average_minute_unlim
    list = @list.select { |i| i.tariff.tariff_name == 'Unlimited' }
    if list.size.zero?
      0
    else
      list.sum(&:minutes) / list.size
    end
  end

  def average_minute_comb
    list = @list.select { |i| i.tariff.tariff_name == 'Combined' }
    if list.size.zero?
      0
    else
      sum = 0
      list.each do |i|
        sum += i.minutes - i.tariff.minutes_volume unless i.minutes <= i.tariff.minutes_volume
      end
      sum / list.size
    end
  end

  def average_minute_time
    list = @list.select { |i| i.tariff.tariff_name == 'Time-based' }
    if list.size.zero?
      0
    else
      list.sum(&:minutes) / list.size
    end
  end

  def find_one_tariff(tariff)
    @list.select { |i| i.tariff.tariff_name == tariff }.sort_by(&:surname)
  end

  def unprofitable
    unprofitable_tariffs = []
    @list.each do |subscriber|
      unprofitable_subscriber = subscriber.profitable_tariff
      unprofitable_tariffs.append([subscriber, unprofitable_subscriber]) if unprofitable_subscriber
    end
    unprofitable_tariffs
  end

  def write_file(filename)
    f = File.new(filename, 'w')
    text = "name;surname;phone_num;tariff;minutes\n"
    @list.each do |subscriber|
      text += subscriber.to_csv_row
    end
    f.syswrite(text)
  end
end
