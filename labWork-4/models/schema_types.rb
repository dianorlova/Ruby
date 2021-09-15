# frozen_string_literal: true

require 'dry-types'

# Tupes
module SchemaTypes
  include Dry.Types

  StrippedString = self::String.constructor(&:strip)
end
