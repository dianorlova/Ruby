# frozen_string_literal: true

require 'dry-schema'

require_relative 'tariff_type'
require_relative 'schema_types'

SubscribersAddFormSchema = Dry::Schema.Params do
  required(:surname).filled(SchemaTypes::StrippedString)
  required(:name).filled(SchemaTypes::StrippedString)
  required(:tariff).filled(SchemaTypes::StrippedString, included_in?: TariffType.all_types)
  required(:minutes).filled(:float, gt?: 0)
end
