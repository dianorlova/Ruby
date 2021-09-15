# frozen_string_literal: true

require 'forme'
require 'roda'
require_relative 'models'

# The core class of the web app for managing tests
class TestApp < Roda
  opts[:root] = __dir__
  plugin :environments
  plugin :forme
  plugin :render

  configure :development do
    plugin :public
    opts[:serve_static] = true
  end

  # перезаписали в глобал. переменную, чтобы не было многопоточности
  opts[:tests] = TestList.new([
                                Test.new('Лаборатоная №1', '2020-04-05', 'Проверка начальных знаний'),
                                Test.new('Лаборатоная №2', '2020-05-05', 'Проверка знаний'),
                                Test.new('Лаборатоная №3', '2020-06-05', 'Проверка конечных знаний')
                              ])

  route do |r|
    r.public if opts[:serve_static]

    # @tests = TestList.new([
    #                         Test.new('Лаборатоная №1', '2020-04-05', 'Проверка начальных знаний'),
    #                         Test.new('Лаборатоная №2', '2020-05-05', 'Проверка знаний'),
    #                         Test.new('Лаборатоная №3', '2020-06-05', 'Проверка конечных знаний')
    #                       ])

    r.root do
      'Hello world!'
    end

    # обработчик(контроллер)
    # в views также называем файл (tests.erb)
    r.on 'tests' do
      # по этому пути обращаются именно к тестам
      r.is do
        # puts(r.params['date'])
        # puts(r.params['duration'])
        @params = DryResultFormeAdapter.new(TestFilterFromSchema.call(r.params))  # адаптер оборачивает схему
        # @params = InputValidators.check_date_description(r.params['date'], r.params['description']) # проверили параметры # возвратит хеш
        p opts[:tests]
        # фильтр вызываем только в случае, если данные были введены верно
        # @filtered_tests = if @params[:errors].empty?
        #                     opts[:tests].filter(@params[:date], @params[:description]) # фильтруем

        #                   else
        #                     opts[:tests].all_tests
        #                   end
        @filtered_tests = if @params.success? # если фильтрация прошла успешно
                            opts[:tests].filter(@params[:date], @params[:description]) # фильтруем по этим данным
                          else
                            opts[:tests].all_tests
                          end
        p @filtered_tests

        # @some_tests = [1, 2, 15]
        # view('tests', locals: { data: 'Данные из контроллера' })
        view('tests') # отображение результатов, в скобочках - название шаблона
      end
      # tests/new
      r.on 'new' do
        # при get показываем формочку для ввода новых данных
        r.get do
          @params = {}
          view('new_test')
        end

        r.post do 
          @params = DryResultFormeAdapter.new(NewTestFormSchema.call(r.params))
          # @params = InputValidators.check_test(r.params['name'], r.params['date'], r.params['description'])
          # когда пользователь ввёл данные на форме ВЕРНО
          # if @params[:errors].empty?
          if @params.success?
            # здесь тоже заменили @tests -> opts[:tests]
            opts[:tests].add_test(Test.new(@params[:name], @params[:date], @params[:description]))
            p opts[:tests]
            # перенаправим пользователя к списку тестов, где он их сможет посмотреть
            r.redirect '/tests'
          else
            # если ошибки были, то показываем снова форму ввода
            view('new_test')
          end
        end
      end
    end
  end
end
