# frozen_string_literal: true


# class describes the essence of a complex number
class MyComplex
  attr_reader :real, :imaginary

  def initialize(real, imaginary)

    @real = Float(real)
    @imaginary = Float(imaginary)
  end

  def to_s
    "#{@real} + i * #{@imaginary}"
  end

  def add(other)
    real_new = @real + other.real
    imaginary_new = @imaginary + other.imaginary
    MyComplex.new(real_new, imaginary_new)
  end

  def multiply(other)
    real_new = @real * other.real - @imaginary * other.imaginary
    imaginary_new = @real * other.imaginary + other.real * @imaginary
    MyComplex.new(real_new, imaginary_new)
  end

  def sub(other)
    real_new = @real - other.real
    imaginary_new = @imaginary - other.imaginary
    MyComplex.new(real_new, imaginary_new)
  end
end
