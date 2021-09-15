# frozen_string_literal: true

# This class describes the entity Student
class Student
  attr_reader :surname, :name, :middle_name, :date_of_birth, :sex, :class_number, :educational_institution

  def initialize(surname, name, middle_name, date_of_birth, sex, class_number, educational_institution)
    @surname = surname
    @name = name
    @middle_name = middle_name
    @date_of_birth = Date.strptime(date_of_birth, '%Y-%m-%d')
    @sex = sex
    @class_number = [class_number.slice(0...-1),class_number[-1]]
    @educational_institution = educational_institution.split(" №")
  end

  def to_s
    "#{surname},#{name},#{middle_name},#{date_of_birth},#{sex},#{class_number},#{educational_institution}"
  end
end
