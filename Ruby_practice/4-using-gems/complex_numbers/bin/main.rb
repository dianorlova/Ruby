# frozen_string_literal: true

# if RUBY_PLATFORM.include?('mingw32')
#     Encoding.default_external = Encoding::CP866
# end
require 'tty-prompt'
require_relative '../lib/my_complex'
require 'rubygems'
require 'bundler/setup'
require 'chunky_png'
def main
  # real = gets.chomp
  # imaginary = gets.chomp
  # obj_zero = MyComplex.new(real,imaginary)

  obj_one = MyComplex.new(1, 2)
  obj_two = MyComplex.new(3, 5)
  
  prompt = TTY::Prompt.new
  real = prompt.ask("real = ").to_i
  imaginary = prompt.ask("imaginary = ").to_i
  obj_three = MyComplex.new(real,imaginary)
  puts obj_three
  # p obj_zero
  # puts obj_zero.real
  # puts obj_zero.imaginary

  p obj_one
  puts obj_one

  p obj_two
  puts obj_two

  png = ChunkyPNG::Image.new(26, 26, ChunkyPNG::Color::TRANSPARENT )
  png.line(13,0,13,26,'darkred')
  png.line(0,13,26,13,'green')
  png.compose_pixel(13,13,'black')
  x1 = obj_one.real + 13
  y1 = obj_one.imaginary + 13 - 4
  # нужно пересчитывать координаты
  png.compose_pixel(x1,y1,'black')
  png.compose_pixel(obj_two.real,obj_two.imaginary,'black')
  png.compose_pixel(obj_three.real,obj_three.imaginary,'black')
  png.save('map.png', :interlace => true)

  puts 'Operations on complex numbers'

  puts 'Addition'
  new_obj1 = obj_one.add(obj_two)
  p new_obj1
  puts new_obj1

  #   puts 'Multiplication'
  #   new_obj2 = obj_one.multiply(obj_two)
  #   p new_obj2
  #   puts new_obj2

  #   puts 'Subtraction'
  #   new_obj3 = obj_one.sub(obj_two)
  #   p new_obj3
  #   puts new_obj3
end

main if __FILE__ == $PROGRAM_NAME
