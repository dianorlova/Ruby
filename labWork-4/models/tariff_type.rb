# frozen_string_literal: true

# TariffType
module TariffType
  UNLIMITED = 'Безлимитный'
  COMBINED = 'Комбинированный'
  TIMED = 'Повременный'

  def self.all_types
    [UNLIMITED, COMBINED, TIMED]
  end

  def self.count
    TariffType.all_types.size
  end
end
