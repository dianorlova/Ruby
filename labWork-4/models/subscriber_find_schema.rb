# frozen_string_literal: true

require 'dry-schema'
SubscriberFindSchema = Dry::Schema.Params do
  required(:telephone).filled(:integer, gteq?: 10, lteq?: 99)
end
