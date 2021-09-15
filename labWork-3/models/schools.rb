# frozen_string_literal: true

require 'csv'
require_relative 'student'
require_relative 'school'
# Schools
class Schools
  attr_reader :schools

  def initialize
    @schools = Hash.new do |hash, key|
      hash[key] = School.new(key)
    end
  end

  def load_from_csv_file(file_path)
    csv = CSV.read(file_path, headers: false, col_sep: ',')
    csv.each do |row|
      student = Student.new(row[0], row[1], row[2], row[3], row[4])
      name_group = row[5]
      name_school = row[6]
      @schools[name_school].add_student_in_group(name_group, student)
    end
  end

  def sorted_schools_by_type_and_number
    @schools.values.sort_by do |school|
      [school.type,
       school.number]
    end
  end

  def filter_by_type(type)
    @schools.select { |_key, value| type == value.type }.values.sort_by do |school|
      [school.type,
       school.number]
    end
  end
end
