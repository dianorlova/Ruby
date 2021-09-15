# frozen_string_literal: true

require 'forwardable'
class TestList
  extend Forwardable
  def_delegator :@tests, :each, :each_test # хотим чтобы метод each у @tests был доступен как each_test

  def initialize(tests = [])
    @tests = tests
  end

  def add_test(test)
    @tests.append(test)
  end

  # возвращает массив, в котором находятся все тесты
  # этот метод вызывается в том случае, если фильтр не сработал
  def all_tests
    @tests.dup
  end

  # возвращает список тех тестов, которые прошли фильтрацию
  def filter(date, description)
    @tests.select do |test|
      next if date && !date.empty? && date != test.date
      next if description && !description.empty? && !test.description.include?(description)

      true  # в остальных случая подходит
    end
  end
end
