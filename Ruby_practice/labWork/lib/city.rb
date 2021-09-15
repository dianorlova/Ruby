# frozen_string_literal: true

require_relative '../lib/student'

require 'csv'

# Class containing students all over the city
class City
  attr_reader :students

  def initialize
    @students = []
  end

  def init_from_list(list)
    @students = list
  end

  def read_in_csv_data(path)
    CSV.foreach(path) do |row|
      student = Student.new(row[0],row[1],row[2],row[3],row[4],row[5],row[6])
      @students.push(student)
    end
  end

  def sort_by_school_class_date
    sort_city = City.new
    sort_city.init_from_list(@students.sort_by do |s|
      [s.educational_institution[1].to_i,
       s.class_number[0].to_i,
       s.date_of_birth]
    end)
    sort_city
  end

  def classes_in_school(school)
    month = ['Январь', 'Февраль', 'Март', 'Апрель', 
             'Май', 'Июнь', 'Июль', 'Август', 
             'Сентябрь', 'Октябрь', 'Ноябрь', 'Декабрь']
    classes = Hash.new([])
    for s in school
      num_class = ""
      if s.class_number[0].size == 1
        num_class = "0"
      end
      num_class += s.class_number.join("_")
      full_name = [s.surname, s.name, s.middle_name].join(" ")
      if classes.has_key?(num_class)
        classes[num_class].push([full_name,
                                 month[s.date_of_birth.mon],
                                 s.date_of_birth.mday])
      else
        classes[num_class] = [[full_name,
                               month[s.date_of_birth.mon],
                               s.date_of_birth.mday]]
      end
    end
    classes
  end

  def select_school(view, num)
    school = []
    for st in @students
      if (st.educational_institution[0] == view) and (st.educational_institution[1] == num)
        school.push(st)
      end
    end
    classes_in_school(school)
  end

  def upload_to_csv(path)
    csv = CSV.open(path, 'w')
    @students.each do |s|
      csv << [s.surname,
              s.name,
              s.middle_name,
              s.date_of_birth,
              s.sex,
              s.class_number.join,
              s.educational_institution.join(' №')]
    end
  end
end