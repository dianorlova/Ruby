# frozen_string_literal: true

require 'csv'
require_relative 'subscriber'

# SubscriberList
class SubscriberList
  def initialize
    @subscribers = []

    @telephones = []
  end

  def load_from_csv_file(file_path)
    csv = CSV.read(file_path, headers: true, col_sep: ',')
    csv.each do |row|
      @subscribers.append(Subscriber.new(row['surname'], row['name'], Integer(row['telephone']),
                                         row['tariff'], row['minutes']))
    end
  end

  def all_subscribers
    @subscribers
  end

  def add_subscriber(parameters)
    rnd = Random.new
    telephone = rnd.rand(10..99)
    telephone = rnd.rand(10..99) while @telephones.include?(telephone)
    subscriber = Subscriber.new(
      parameters[:surname],
      parameters[:name],
      telephone,
      parameters[:tariff],
      0
    )
    @telephones.append(telephone)
    @subscribers.append(subscriber)
  end

  # def invalid_telephone
  #   if (@telephones.size >99)
  # end
  def delete_subscriber(telephone)
    @subscribers.delete_if { |subscriber| subscriber.telephone == telephone }
    @telephones.delete_if { |tel| tel == telephone }
  end

  def subscriber_by_telephone(telephone)
    @subscribers.find { |subscriber| subscriber.telephone == telephone }
  end

  def group_by_tariff_and_sort_by_surname
    subscribers_unlimited = @subscribers.select do |sub|
      sub.tariff_type == TariffType::UNLIMITED
    end.sort_by(&:surname)
    subscribers_combined = @subscribers.select do |sub|
      sub.tariff_type == TariffType::COMBINED
    end.sort_by(&:surname)
    subscribers_timed = @subscribers.select do |sub|
      sub.tariff_type == TariffType::TIMED
    end.sort_by(&:surname)
    [subscribers_unlimited, subscribers_combined, subscribers_timed]
  end

  def all_numbers_subscribers
    @subscribers.size
  end

  def number_of_subscribers_of_one_tariff
    [group_by_tariff_and_sort_by_surname[0].size,
     group_by_tariff_and_sort_by_surname[1].size,
     group_by_tariff_and_sort_by_surname[2].size]
  end

  def average_total_cost_of_telephone
    (@subscribers.sum(&:payment_for_last_month) / all_numbers_subscribers).round(2)
  end

  def average_minute_unlim_tariff
    subscribers_unlimited = group_by_tariff_and_sort_by_surname[0]
    (subscribers_unlimited.sum(&:minutes) / subscribers_unlimited.size).round(2)
  end

  def average_minute_comb_tariff
    subscribers_combined = group_by_tariff_and_sort_by_surname[1]
    sum = 0
    count = 0
    subscribers_combined.each do |sub|
      if sub.minutes > sub.tariff.minutes_volume
        sum += sub.minutes
        count += 1
      end
    end
    (sum / count).round(2)
  end

  def average_minute_timed_tariff
    subscribers_timed = group_by_tariff_and_sort_by_surname[2]
    (subscribers_timed.sum(&:minutes) / subscribers_timed.size).round(2)
  end

  def unprofit_tariffs
    result = []
    @subscribers.each do |subscriber|
      profit_tariff = subscriber.profit_tariff
      result.append(subscriber) if profit_tariff
    end
    result
  end
end
