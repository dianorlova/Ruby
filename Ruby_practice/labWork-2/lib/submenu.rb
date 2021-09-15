# frozen_string_literal: true

require_relative '../lib/menu'
# This class describes and executes some of the sub-items of the main menu.
class Submenu
  def initialize(apartments)
    @prompt = TTY::Prompt.new
    @apartments = apartments
  end

  def choice_add_or_remove_appartment(action)
    case action
    when :add then add_apartment
    when :remove then remove_apartment
    end
  end

  def input_apartment
    footage = @prompt.ask('Введите метраж: ')
    number_rooms = @prompt.ask('Введите количество комнат: ')
    address = @prompt.ask('Введите адрес в формате Район,Улица,Номер_Дома' \
         '(пример:Kirovsky district,Lenin Avenue,56): ')
    floor = @prompt.ask('Введите этаж: ')
    house_type = @prompt.select('Введите тип дома:', %w[panel brick])
    number_of_floors = @prompt.ask('Введите количество этажей в доме: ')
    cost = @prompt.ask('Введите стоимость в млн: ')
    puts 'Интервал вводить в формате a-b, где а и b это начало и конец интервала соответственно.'
    puts 'Элементы списка вводить без пробелов через запятую.'
    puts 'Параметры обмена вводить через точку с запятой.'
    list_param = @prompt.ask('Введите параметры форматом Интервал_Метража;'\
        'Интервал_Кол-ва_Комнат;Список_районов;Cписок_подходящих_этажей;Интервал_стоимости(млн): ')
    Apartment.new([footage, number_rooms, address, floor, house_type, number_of_floors,
                   cost, list_param])
  end

  def add_apartment
    @apartments.add(input_apartment)
  end

  def remove_apartment
    # @prompt.select("Выберите квартиру из списка:",@apartments.list_apartments)
    # @apartments.del(input_apartment)
    @apartments.del(@prompt.select("Выберите квартиру из списка:",@apartments.list_apartments))
  end
end
