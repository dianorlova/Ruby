require 'delegate'

User = Struct.new(:first_name, :last_name)

class UserDecorator < SimpleDelegator
  def full_name
    "#{first_name} #{last_name}"
  end
end

decorated_user = UserDecorator.new(User.new("John", "Doe"))
pp decorated_user.full_name  #"John Doe"
decorated_user.first_name  #"John"
decorated_user.last_name  #"Doe" 