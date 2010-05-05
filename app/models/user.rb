class User < ActiveRecord::Base
	
  acts_as_authentic do |c|
		c.account_mapping_mode :internal
		c.account_merge_enabled true
    c.validates_format_of_login_field_options({
      :with => /\A\w[\w\.+\-_ ]+$/ ,
      :message => "может содержать только буквы латинского алфавита, цифры, пробел и .-_"
    })
	end
  
  def validate_password_not_rpx?
    if session_class.controller.params[:user] then
      !session_class.controller.params[:user][:password].blank? or !session_class.controller.params[:user][:password_confirmation].blank?
    end
  end

	#validates_uniqueness_of   :login, :case_sensitive => false
  #validates_presence_of :email
  #validates_confirmation_of :password, :if => :using_password?
  #attr_accessible :login, :email, :password, :password_confirmation, :rpx_identifier 

  has_many :assignments, :dependent => :destroy
  has_many :roles, :through => :assignments
  has_many :posts

  def self.find_by_login_or_email(login)
    User.find_by_login(login) || User.find_by_email(login)
  end

  def role_symbols
    @role_symbols ||= (roles || []).map { |role| role.name.underscore.to_sym }
  end

  def deliver_register_complete!
    Notifier.deliver_register_complete(self)
  end

end
