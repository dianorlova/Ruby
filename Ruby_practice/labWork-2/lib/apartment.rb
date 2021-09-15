# frozen_string_literal: true

require_relative '../lib/parameters'
require_relative '../lib/address'

# The class describes the apartment
class Apartment
  attr_reader :footage, :number_rooms, :address, :floor, :house_type, :number_of_floors, :cost,
              :list_param

  include Comparable

  def initialize(lst_arg)
    footage, number_rooms, address, floor, house_type, number_of_floors, cost, list_param = *lst_arg
    @footage = footage.scan(/\d*[.,]?\d+/)[0].to_f
    @number_rooms = number_rooms.to_i
    @address = Address.new(address.split(','))
    @floor = floor.to_i
    @house_type = house_type
    @number_of_floors = number_of_floors.to_i
    @cost = cost.to_f
    @list_param = Parameters.new(list_param.split(';'))
  end

  def to_s
    "> #{@footage} кв.м., #{@number_rooms}, #{address}, #{floor}, " \
      "#{house_type}, #{number_of_floors}, #{cost} млн#{list_param}"
  end

  def <=>(other)
    [@footage, @number_rooms, @address, @floor, @house_type, @number_of_floors, @cost,
     @list_param] <=>
      [other.footage, other.number_rooms, other.address, other.floor, other.house_type,
       other.number_of_floors, other.cost, other.list_param]
  end
end
