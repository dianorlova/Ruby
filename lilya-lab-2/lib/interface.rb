# frozen_string_literal: true

require_relative './menu'

# menu structure
module Interface
  MAIN_MENU = [
    { name: 'Добавить абонента', value: :add },
    { name: 'Удалить абонента', value: :delete },
    { name: 'Найти абонента/абонентов', value: :get },
    { name: 'Составить статистику за месяц', value: :stat },
    { name: 'Найти абонентов, которые используют невыгодный тариф', value: :tariff },
    { name: 'Завершить работу приложения', value: :exit }
  ].freeze

  GET_MENU = [
    { name: 'Найти абонента по номеру телефона', value: :v1 },
    { name: 'Найти абонента по фамилии', value: :v2 },
    { name: 'Вывести список всех абонентов', value: :v3 },
    { name: 'Вывести список абонентов тарифного плана: ', value: :v4 },
    { name: 'выйти', value: :exit2 }
  ].freeze

  TARIFF_MENU = [
    { name: 'Безлимитный', value: :unlimited },
    { name: 'Комбинированный', value: :combined },
    { name: 'Повременный', value: :time_based }
  ].freeze

  def show_main_menu
    loop do
      action = @prompt.select('Выберите действие', MAIN_MENU)
      break if action == :exit

      add_subscriber if action == :add
      delete_subscriber if action == :delete
      show_get_menu if action == :get
      create_statistics if action == :stat
      unprofitable_tariff if action == :tariff
    end
  end

  # show_main_menu и show_get_menu лучше объединить как в ТЗ
  def show_get_menu
    action = @prompt.select('Выберите действие', GET_MENU)
    nil if action == :exit2
    find_for_number if action == :v1
    find_for_surname if action == :v2
    find_all if action == :v3
    find_tariff if action == :v4
  end

  def show_tariff_menu
    action = @prompt.select('Выберите тариф', TARIFF_MENU)
    return 'Unlimited' if action == :unlimited
    return 'Combined' if action == :combined
    return 'Time-based' if action == :time_based
  end

  def add_subscriber
    print("введите данные:\n  фамилия>")
    surname = gets
    print('  имя>')
    name = gets
    tariff = Menu.show_tariff_menu
    @subscriber_list.add(surname, name, tariff)
  end
end
