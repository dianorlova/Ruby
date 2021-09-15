# frozen_string_literal: true

require 'tty-prompt'
require_relative '../lib/apartments'
require_relative '../lib/apartment'
require_relative '../lib/submenu'

# This class describes the menu
class Menu
  attr_reader :apartments, :submenu

  CHOICE_OF_ACTION = [
    { name: '1. Добавить/удалить квартиру.', value: :action1 },
    { name: '2. Вывести все квартиры, отсортированные по районам/стоимости/метражу.',
      value: :action2 },
    { name: '3. Вывести все варианты обмена для заданной квартиры с учётом доплаты.',
      value: :action3 },
    { name: '4. Найти всех соседей: предложения для обмена на той же улице.', value: :action4 },
    { name: '5. Статистика квартир.', value: :action5 },
    { name: '6. Вывести несовпадения по кол-ву этажей и виду дома.(Проверка корректности базы)',
      value: :action6 },
    { name: '7. Завершить работу.', value: :action7 }
  ].freeze
  ADD_OR_REMOVE_APARTMENT = [{ name: '1) добавить', value: :add },
                             { name: '1) удалить', value: :remove }].freeze
  CHOICE_PARAM_SORT = [{ name: '1) по районам', value: :district },
                       { name: '2) по стоимости', value: :cost },
                       { name: '3) по метражу', value: :footage }].freeze

  def initialize(apartments)
    @prompt = TTY::Prompt.new
    @apartments = apartments
    @submenu = Submenu.new(apartments)
  end

  def start
    loop do
      case @prompt.select('Добро пожаловать! Выберите действие: ', CHOICE_OF_ACTION)
      when :action1 then add_or_remove_appartment(submenu)
      when :action2 then sort_param
      when :action3 then exchange_options
      when :action4 then find_neighbors
      when :action5 then statistics
      when :action6 then base_check
      else exit
      end
    end
  end

  def add_or_remove_appartment(submenu)
    action = @prompt.select('Выберите действие: ', ADD_OR_REMOVE_APARTMENT)
    submenu.choice_add_or_remove_appartment(action)
  end

  def sort_param
    param = @prompt.select('Выберите параметр: ', CHOICE_PARAM_SORT)
    case param
    when :district then sort_district
    when :cost then sort_cost
    when :footage then sort_footage
    end
  end

  def sort_district
    puts(@apartments.list_apartments.sort_by { |ap| ap.address.district })
  end

  def sort_cost
    puts(@apartments.list_apartments.sort_by(&:cost))
  end

  def sort_footage
    puts(@apartments.list_apartments.sort_by(&:footage))
  end

  def exchange_options
    result = @apartments.exchange_options(@prompt.select("Выберите квартиру из списка:",@apartments.list_apartments))
    return puts 'Список квартир, подходящих для обмена пуст!' if result.empty?

    answer = @prompt.select(
      "\nВыберите квартиру для обмена:\n", result.keys.map do |ap|
                                             {
                                               name: "(Доплата: #{result[ap]}млн) #{ap}", value: ap
                                             }
                                           end
    )
    del_ap = @apartments.list_apartments.delete(answer)
    @apartments.write_data_file(File.expand_path('../data/choice_ap.txt', __dir__), del_ap)
  end

  def find_neighbors
    puts "\nСоседи по улице:"
    puts @apartments.find_neighbors(@prompt.select("Выберите квартиру из списка:",@apartments.list_apartments))
  end

  def statistics
    puts "\nКоличество предложений для обмена по каждому району:"
    apartments.number_proposals_for_each_district.each_pair { |key, value| puts "#{key}: #{value}" }
    puts "\nСредняя стоимость за кв. метр по каждому району:"
    apartments.average_cost_per_meter.each_pair do |key, value|
      puts "#{key}: #{value.round(2)} руб"
    end
    puts "\nКол-во предложений, желающих обменяться на квартиру в этом районе (по каждому району):"
    apartments.number_want_exchange.each_pair { |key, value| puts "#{key}: #{value}" }
  end

  def base_check
    apartments.base_check.each_pair { |key, _value| puts key }
  end



end
