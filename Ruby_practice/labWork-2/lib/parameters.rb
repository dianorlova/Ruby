# frozen_string_literal: true

# Class describes exchange parameters
class Parameters
  attr_reader :meter_interval, :room_interval, :list_districts, :list_floors, :cost_interval

  include Comparable
  def initialize(list_param)
    meter_interval, room_interval, list_districts, list_floors, cost_interval = *list_param
    @meter_interval = meter_interval.scan(/\d*[.,]?\d+/).map(&:to_f)
    @room_interval = room_interval.scan(/\d+/).map(&:to_i)
    @list_districts = list_districts
    @list_floors = list_floors.split(',').map(&:to_i)
    @cost_interval = cost_interval.scan(/\d*[.,]?\d+/).map(&:to_f)
  end

  def to_s
    "\nПараметры обмена: #{@meter_interval.join('-')} кв.м., #{@room_interval.join('-')}, " \
      "#{@list_districts}, #{@list_floors.join(',')}, #{@cost_interval.join('-')} млн"
  end

  def <=>(other)
    [@meter_interval, @room_interval, @list_districts, @list_floors, @cost_interval] <=>
      [other.meter_interval, other.room_interval, other.list_districts, other.list_floors,
       other.cost_interval]
  end
end
