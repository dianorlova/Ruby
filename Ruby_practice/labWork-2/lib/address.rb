# frozen_string_literal: true

# This class describes the address
class Address
  attr_reader :district, :street, :house

  include Comparable
  def initialize(list_address)
    district, street, house = *list_address
    @district = district
    @street = street
    @house = house.to_i
  end

  def to_s
    "#{@district},#{@street},#{@house}"
  end

  def ==(other)
    [@district, @street, @house] == [other.district, other.street, other.house]
  end
end
