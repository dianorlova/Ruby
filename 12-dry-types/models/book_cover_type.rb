# frozen_string_literal: true

# BookCoverType
module BookCoverType
    THIN = 'Тонкая'
    THICK = 'Толстая'

    def self.all_types
        [THICK,THIN]
    end
end