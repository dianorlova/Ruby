# frozen_string_literal: true

require 'roda'
require 'forme'

require_relative 'models'

# SubscriberApplication
class SubscriberApplication < Roda
  opts[:root] = __dir__
  plugin :environments
  plugin :forme
  plugin :render
  plugin :status_handler

  configure :development do
    plugin :public
    opts[:serve_static] = true
  end

  opts[:subscribers] = SubscriberList.new
  opts[:subscribers].load_from_csv_file(File.expand_path('data/info.csv', __dir__))

  status_handler(404) do
    view('not_found')
  end

  route do |r|
    r.public if opts[:serve_static]

    r.root do
      r.redirect '/subscribers'
    end

    r.on 'subscribers' do
      r.is do
        @subscribers = opts[:subscribers].all_subscribers
        view('subscribers')
      end

      r.on 'new' do
        r.get do
          @parameters = {}
          view('subscriber_new')
        end

        r.post do
          @parameters = DryResultFormeWrapper.new(SubscribersAddFormSchema.call(r.params))
          if @parameters.success?
            @subscriber = opts[:subscribers].add_subscriber(@parameters)[-1]
            view('subscriber')
          else
            view('subscriber_new')
          end
        end

      end

      r.on Integer do |telephone|
        @subscriber = opts[:subscribers].subscriber_by_telephone(telephone)
        next if @subscriber.nil?

        r.is do
          view('subscriber')
        end

        r.on 'delete' do
          r.get do
            @parameters = {}
            view('subscriber_delete')
          end

          r.post do
            @parameters = DryResultFormeWrapper.new(SubscriberDeleteSchema.call(r.params))
            if @parameters.success?
              opts[:subscribers].delete_subscriber(@subscriber.telephone)
              r.redirect('/subscribers')
            else
              view('subscriber_delete')
            end
          end
        end
      end

      r.on 'find' do
        r.get do
          @parameters = {}
          view('subscriber_find')
        end

        r.post do
          @parameters = DryResultFormeWrapper.new(SubscriberFindSchema.call(r.params))
          if @parameters.success?
            @subscriber = opts[:subscribers].subscriber_by_telephone(@parameters[:telephone])
            next if @subscriber.nil?

            view('subscriber')
          else
            view('subscriber_find')
          end
        end
      end

      r.on 'groups' do
        r.is do
          @subscribers_groups = opts[:subscribers].group_by_tariff_and_sort_by_surname
          @subscribers_unlimited = @subscribers_groups[0]
          @subscribers_combined = @subscribers_groups[1]
          @subscribers_timed = @subscribers_groups[2]
          view('subscriber_groups')

        end

        r.on Integer do |id|
          @tariff = Tariff.tariff_id(id)
          
          if (id > TariffType.count - 1 ) || id < 0
            view('error_tariff')
          else
            @subscribers_group = opts[:subscribers].group_by_tariff_and_sort_by_surname[id - 1]
            view('group')
          end
        end
      end

      r.on 'statistics' do
        r.is do
          @subscribers = opts[:subscribers]
          @all_numbers_subscribers = @subscribers.all_numbers_subscribers
          @number_of_subscribers_unlim_tariff = @subscribers.number_of_subscribers_of_one_tariff[0]
          @number_of_subscribers_comb_tariff = @subscribers.number_of_subscribers_of_one_tariff[1]
          @number_of_subscribers_timed_tariff = @subscribers.number_of_subscribers_of_one_tariff[2]
          @average_total_cost_of_telephone = @subscribers.average_total_cost_of_telephone
          @average_minute_unlim_tariff = @subscribers.average_minute_unlim_tariff
          @average_minute_comb_tariff = @subscribers.average_minute_comb_tariff
          @average_minute_timed_tariff = @subscribers.average_minute_timed_tariff
          view('statistics')
        end
      end

      r.on 'unprofit_tariff' do
        r.is do
          @subscribers_unprofit = opts[:subscribers].unprofit_tariffs
          p @subscribers_unprofit[0]
          next if @subscribers_unprofit.nil?

          view('subscribers_unprofit')
        end
      end
    end
  end
end
