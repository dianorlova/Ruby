# frozen_string_literal: true

require 'delegate'
require 'forme'

class DryResultFormeWrapper < SimpleDelegator
  def initialize(parameters)
    super(parameters)
    @parameters = parameters
    @errors = parameters.errors
  end

  def forme_input(form, field, opts)
    new_opts = opts.dup
    new_opts[:value] = @parameters[field]
    new_opts[:name] = field
    new_opts[:error] = @errors[field].join(', ') if @parameters.error?(field)

    type = new_opts.delete(:type)
    value = new_opts.delete(:value) if %i[checkbox radio].include?(type)
    form._input(type, **new_opts)
  end
end
