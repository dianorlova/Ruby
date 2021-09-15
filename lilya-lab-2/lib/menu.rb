# frozen_string_literal: true

require 'tty-prompt'
require_relative './subscriber'
require_relative './tariff'
require_relative './subscriber_list'
require_relative './interface'

# main menu
class Menu
  attr_reader :subscriber_list

  include Interface
  def initialize
    @prompt = TTY::Prompt.new
    @subscriber_list = SubscriberList.new
    @subscriber_list.read_in_csv('./data/data.csv')
  end

  def add_subscriber
    print("введите данные:\n")
    surname = @prompt.ask('фамилия')
    name = @prompt.ask('имя')
    tariff = show_tariff_menu
    @subscriber_list.add(surname, name, tariff)
  end

  def delete_subscriber
    print('номер абонента, которого удалить>')
    number = Integer(gets)
    @subscriber_list.delete(number)
  end

  def create_statistics
    print("общее количество абонентов: #{@subscriber_list.count_all}\n")
    print("количество абонентов безлимитного тарифа: #{@subscriber_list.count_tariff('Unlimited')}\n")
    print("количество абонентов комбинированного тарифа: #{@subscriber_list.count_tariff('Combined')}\n")
    print("количество абонентов повременного тарифа: #{@subscriber_list.count_tariff('Time-based')}\n")
    print("средняя общая стоимость телефонной связи за месяц: #{@subscriber_list.average_cost}\n")
    print("среднее количество минут телефонных разговоров на безлимитном тарифе: #{@subscriber_list
                                                                                     .average_minute_unlim}\n")
    print("среднее количество минут телефонных разговоров сверх лимита на комбинированном тарифе: #{@subscriber_list
                                                                                              .average_minute_comb}\n")
    print("среднее количество минут телефонных разговоров на повременном тарифе: #{@subscriber_list
                                                                                     .average_minute_time}\n")
  end

  def unprofitable_tariff
    list = @subscriber_list.unprofitable
    list.each do |sub|
      print("#{sub[0].surname} (#{sub[0].phone_num}): #{sub[0].minutes}
  не выгодно: #{sub[0].tariff} (#{sub[0].calculate_payment})
  выгодно: #{sub[1]} (#{sub[0].calculate_payment_other(sub[1])})\n")
    end
  end

  def find_for_number
    begin
      number = Integer(@prompt.ask('Введите номер'))
    rescue ArgumentError
      print("неправильно набран номер\n")
      return
    end
    subscriber = @subscriber_list.find_for_number(number)
    unless subscriber
      print("такого номера нет\n")
      return
    end
    print("#{subscriber.surname} #{subscriber.name}: #{subscriber.phone_num} (#{subscriber.tariff})\n")
  end

  def find_for_surname
    surname = @prompt.ask('введите фамилию')
    subscriber = @subscriber_list.find_for_surname(surname.strip)
    unless subscriber
      print("такого человека нет\n")
      return
    end
    print("#{subscriber.surname} #{subscriber.name}: #{subscriber.phone_num} (#{subscriber.tariff})\n")
  end

  def print_tariff(tariff)
    list = @subscriber_list.find_one_tariff(tariff)
    list.each do |i|
      print("  #{i.surname} #{i.name}: #{i.phone_num}\n")
    end
  end

  def find_all
    print("Безлимитный:\n")
    print_tariff('Unlimited')
    print("Комбинированный:\n")
    print_tariff('Combined')
    print("Повременный:\n")
    print_tariff('Time-based')
  end

  def find_tariff
    tariff = show_tariff_menu
    list = @subscriber_list.find_one_tariff(tariff)
    list.each do |i|
      print("  #{i.surname} #{i.name} (#{i.phone_num}): #{i.calculate_payment}\n")
    end
    nil
  end
end
