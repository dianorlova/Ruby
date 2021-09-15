require 'dry-schema'

TestFilterFromSchema = Dry::Schema.Params do
  # поля могут появляться, а могут и не появляться
  # есть возможно поле date, если оно есть то значение может быть строкой и соответствовать формату
  optional(:date).maybe(:string, format?: /\d{4}-\d{2}-\d{2}/)
  optional(:discription).maybe(:string)
end
