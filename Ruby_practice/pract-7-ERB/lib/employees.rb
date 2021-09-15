require_relative '../lib/employee'
require 'yaml'
class Employees
    attr_reader :employees
    def initialize
        @employees = []
    end

    def read_file
        hash = YAML.load_file(File.expand_path('../data/info.yml', __dir__))
        hash['people'].each do |human|
            employee = Employee.new(human['name'],human['patronymic'],human['surname'],human['email'],human['avatar'])
            @employees.append(employee)
        end
    end

    # Получение доступа к контексту объекта
    def get_binding(people)
        binding
    end


end
