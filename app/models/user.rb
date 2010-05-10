class User < ActiveRecord::Base
	
  before_create :set_default_role

  acts_as_authentic do |c|
		c.account_mapping_mode :internal
		c.account_merge_enabled true
    c.validate_login_field = false
    validates_uniqueness_of :login, :case_sensitive => false
    validates_format_of :login, 
      :with => /^[0-9]*[a-zA-Z0-9]+$/,
      :message => "может содержать только буквы латинского алфавита и цифры"
	end
  
  # true если будем проверять на валидность пароль и подтверждение пароля
  def validate_password_not_rpx?
    # debugger

    # в script/console не создавалась роль, todo проверить
    params = session_class.controller.try(:params)
    return false unless params

    if new_record?
      return true
    elsif params[:user] && (params[:user][:password].any? ^ params[:user][:password_confirmation].any?)
      return true
    elsif params[:add_rpx]
      return false
    end

    return false
  end

  #attr_accessible :login, :email, :password, :password_confirmation, :rpx_identifier 

  has_many :assignments, :dependent => :destroy
  has_many :roles, :through => :assignments
  has_many :posts

  def self.find_by_login_or_email(login)
    User.find_by_login(login) || User.find_by_email(login)
  end

   def role?(role)
    @roles ||= roles.map(&:name)
    @roles.include? role.to_s
  end

  def set_default_role
    if User.all.count == 0
      roles << Role.create(:name => "admin")
    else
      roles << Role.find_or_create_by_name("user")
    end
  end

  def deliver_register_complete!
    Notifier.deliver_register_complete(self)
  end

end
