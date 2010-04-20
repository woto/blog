class User < ActiveRecord::Base
  acts_as_authentic
  
  has_many :assignments, :dependent => :destroy
  has_many :roles, :through => :assignments
  has_many :posts
 
  def role_symbols
    @role_symbols ||= (roles || []).map { |role| role.name.underscore.to_sym }
  end

  def deliver_register_complete!
    Notifier.deliver_register_complete(self)
  end

end
