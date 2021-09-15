# frozen_string_literal: true

require 'dry-schema'

require_relative 'book_cover_type'
require_relative 'schema_types'

BookFormSchema = Dry::Schema.Params do
  # required(:title).filled(:string)
  # required(:author).filled(:string)
  required(:title).filled(SchemaTypes::StrippedString)
  required(:author).filled(SchemaTypes::StrippedString)
  required(:published_on).filled(:date)
  required(:mark).filled(:integer, gteq?: 1,lteq?: 5)  # целое число от 1 до 5
  required(:circulation).filled(:float, gt?: 0)  # положительное веществ число
  required(:cover_type).filled(SchemaTypes::StrippedString, included_in?: BookCoverType.all_types) 
end
