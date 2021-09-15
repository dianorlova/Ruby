# frozen_string_literal: true

# Group
class Group
  attr_reader :name, :students

  def initialize(name)
    @name = name
    @students = []
  end

  def number
    @name.slice(0...-1).to_i
  end

  def letter
    @name[-1]
  end

  def add_student(student)
    @students.append(student)
  end

  def count_all_students_in_group
    @students.size
  end

  def count_girls_in_group
    @students.find_all { |student| student.sex == 'женский' }.size
  end

  def count_boys_in_group
    @students.find_all { |student| student.sex == 'мужской' }.size
  end

  def students_sort_by_surname_name_patronymic
    @students.sort_by do |student|
      [student.surname, student.name, student.patronymic]
    end
  end

  def filter_by_group_letter(index_letter)
    selected_students = @students.select do |student|
      index_letter == ('А'..'Я').to_a.index(student.surname[0]).to_s
    end
    selected_students.sort_by do |student|
      [student.surname, student.name, student.patronymic]
    end
  end
end
