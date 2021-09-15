# frozen_string_literal: true

require 'dry-types'

# Tupes
module SchemaTypes
  include Dry.Types

  # обращаемся к модулю, берём описание строки и через конструктор отбрасываем пробелы
  StrippedString = self::String.constructor(&:strip)  # новый тип StrippedString(обрезанная строка)
end
