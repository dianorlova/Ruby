# frozen_string_literal: true

require 'roda'
require_relative 'models'

# StudentApp
class StudentApp < Roda
  opts[:root] = __dir__
  plugin :environments
  plugin :render

  configure :development do
    plugin :public
    opts[:serve_static] = true
  end

  opts[:schools] = Schools.new
  opts[:schools].load_from_csv_file(File.expand_path('models/students.csv', __dir__))

  route do |r|
    r.public if opts[:serve_static]
    r.root do
      r.redirect '/schools'
    end
    r.get 'schools' do
      @filtered_schools = if r.params['type'].nil?
                            opts[:schools].sorted_schools_by_type_and_number
                          else
                            opts[:schools].filter_by_type(r.params['type'])
                          end
      view('schools')
    end
    r.on String, Integer do |school_type, school_number|
      @filtered_schools = opts[:schools].sorted_schools_by_type_and_number
      @school = @filtered_schools.find do |school|
        school.type == school_type && school.number == school_number.to_i
      end
      r.is do
        r.get do
          @flag = false
          view('school')
        end
      end
      r.is 'reverse' do
        r.get do
          @flag = true
          view('school')
        end
      end
      r.on 'group', String do |group_name|
        r.is do
          r.get do
            group_name = group_name.split('_')
            group_name = group_name[0].to_s + ('а'..'я').to_a[group_name[1].to_i]
            @group = @school.groups.values.find { |group| group.name == group_name }
            @filtered_students = if @group.filter_by_group_letter(r.params['index_letter']).empty?
                                   @group.students_sort_by_surname_name_patronymic
                                 else @group.filter_by_group_letter(r.params['index_letter'])
                                 end
            view('group')
          end
        end
      end
    end
  end
end
