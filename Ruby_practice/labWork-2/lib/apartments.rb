# frozen_string_literal: true

require_relative '../lib/apartment'
# This class describes a list of apartments
class Apartments
  attr_reader :list_apartments

  def initialize
    @list_apartments = []
  end

  def read_data_file(path_file)
    file = File.new(path_file, 'r')
    file.each do |row|
      apartment = Apartment.new(row.split('; '))
      @list_apartments.append(apartment)
    end
  end

  def write_data_file(path_file, ap_choice)
    file = File.open(path_file, 'w')
    file << ap_choice
    file.close
  end

  def add(other_apartment)
    @list_apartments.append(other_apartment)
  end

  def del(other_apartment)
    @list_apartments.delete(other_apartment)
  end

  def interval_check(interval1, num2, interval2, num1)
    ((num1 <= interval2[1]) && (num1 >= interval2[0]) && (
        num2 <= interval1[1]) && (num2 >= interval1[0]))
  end

  def check_include(list1, num2, list2, num1)
    (list1.include?(num2) && list2.include?(num1))
  end

  def parameters_check(app, other_ap)
    other_p = other_ap.list_param
    ap_p = app.list_param
    name_district_other = other_ap.address.district.split[0]
    name_district_ap = app.address.district.split[0]
    param1 = interval_check(other_p.meter_interval, app.footage, ap_p.meter_interval,
                            other_ap.footage)
    param2 = interval_check(other_p.room_interval, app.number_rooms, ap_p.room_interval,
                            other_ap.number_rooms)
    param3 = check_include(ap_p.list_districts, name_district_other, other_p.list_districts,
                           name_district_ap)
    param4 = check_include(ap_p.list_floors, other_ap.floor, other_p.list_floors, app.floor)
    param5 = interval_check(other_p.cost_interval, app.cost, ap_p.cost_interval, other_ap.cost)
    (param1 && param2 && param3 && param4 && param5)
  end

  def exchange_options(other_ap)
    hash_apartaments = Hash.new(0)
    @list_apartments.each do |ap|
      hash_apartaments[ap] = (ap.cost - other_ap.cost) if parameters_check(ap, other_ap)
    end
    hash_apartaments
  end

  def find_neighbors(other_ap)
    @list_apartments.filter { |ap| ap.address.street == other_ap.address.street }
  end

  def number_proposals_for_each_district
    result = Hash.new(0)
    @list_apartments.each do |ap|
      result[ap.address.district] = @list_apartments.find_all do |x|
        x.address.district == ap.address.district
      end.length
    end
    result
  end

  def average_cost_per_meter
    result = Hash.new(0)
    sum_meter = Hash.new(0)
    universal_count_district = Hash.new(0)
    @list_apartments.each do |ap|
      cost_per_meter = sum_meter[ap.address.district]
      sum_meter[ap.address.district] = cost_per_meter + ap.cost / ap.footage
      universal_count_district[ap.address.district] += 1
    end
    sum_meter.each_key do |district|
      result[district] = (sum_meter[district] / universal_count_district[district]) * 1_000_000
    end
    result
  end

  def number_want_exchange
    result = Hash.new(0)
    @list_apartments.each do |ap|
      result[ap.address.district] = @list_apartments.find_all do |x|
        x.list_param.list_districts.include?(ap.address.district.split[0])
      end.length
    end
    result
  end

  def base_check
    result = Hash.new([])
    @list_apartments.each do |ap|
      temp = @list_apartments.filter do |x|
        (x.address == ap.address) && (
            (x.number_of_floors != ap.number_of_floors) || (x.house_type != ap.house_type))
      end
      result[ap] += temp unless temp.empty?
    end
    result
  end
end
