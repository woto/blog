class User < ActiveRecord::Base
  acts_as_authentic

  def deliver_register_complete!
    Notifier.deliver_register_complete(self)
  end

end
