# frozen_string_literal: true

require 'dry-schema'
SubscriberDeleteSchema = Dry::Schema.Params do
  required(:confirmation).filled(true)
end
