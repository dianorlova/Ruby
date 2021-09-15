# frozen_string_literal: true

require_relative '../lib/menu'
require_relative '../lib/subscriber_list'
def main
  menu = Menu.new
  menu.show_main_menu
  menu.subscriber_list.write_file('./data/data.csv')
end

main if __FILE__ == $PROGRAM_NAME
