# frozen_string_literal: true

require 'csv'

require_relative 'group'
# School
class School
  attr_reader :groups, :name

  def initialize(name)
    @groups = Hash.new do |hash, key|
      hash[key] = Group.new(key)
    end
    @name = name
  end

  def type
    {
      'Гимназия' => 'gymnasium',
      'Лицей' => 'lyceum',
      'Школа' => 'school'
    }[@name.split(' №')[0]]
  end

  def number
    @name.split(' №')[1].to_i
  end

  def add_student_in_group(name_group, student)
    @groups[name_group].add_student(student)
  end

  def count_all_people_in_school
    count = 0
    @groups.each_value do |group|
      count += group.count_all_students_in_group
    end
    count
  end

  def count_all_girls_in_school
    count = 0
    @groups.each_value do |group|
      count += group.count_girls_in_group
    end
    count
  end

  def count_all_boys_in_school
    count = 0
    @groups.each_value do |group|
      count += group.count_boys_in_group
    end
    count
  end

  def groups_list_in_school
    @groups.values.sort_by do |group|
      [group.number, group.letter]
    end
  end
end
