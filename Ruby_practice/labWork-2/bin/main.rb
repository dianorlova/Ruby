# frozen_string_literal: true

require_relative '../lib/menu'

def main
  apartments = Apartments.new
  apartments.read_data_file(File.expand_path('../data/info_english.txt', __dir__))

  menu = Menu.new(apartments)
  menu.start
end

main if __FILE__ == $PROGRAM_NAME
