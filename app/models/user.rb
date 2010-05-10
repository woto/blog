class User < ActiveRecord::Base

  has_many :assignments, :dependent => :destroy
  has_many :roles, :through => :assignments
  has_many :posts

  acts_as_authentic do |c|
	  c.account_mapping_mode :internal
	  c.account_merge_enabled true
    
    c.validate_login_field = false
    c.validate_email_field = false
  
    # Проверяем если не rpx аутентификация
    validates_uniqueness_of :email, :case_sensitive => false, :unless => :addrpxauth
    validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :unless => :addrpxauth
    validates_uniqueness_of :login, :case_sensitive => false, :unless => :addrpxauth
    validates_format_of :login, :with => /^[0-9]*[a-zA-Z0-9]+$/i, :unless => :addrpxauth
  end

  # собственные валидаторы, взамен валидаторов authlogic делают валидацию при изменении записи, что отказывался делать authlogic
  def addrpxauth
    debugger
    begin
      session_class.controller.params[:add_rpx].any?
    rescue
      return false
    else
      return true
    end
  end

  # Заводим зарегистрировавшихся в нужную группу при создании записи
  before_create do |object|
    if User.all.count == 0
      object.roles << Role.find_or_create_by_name("admin")
    else
      object.roles << Role.find_or_create_by_name("user")
    end
  end

  # Перегружаем, т.к. по умолчанию еще делается проверка на using_rpx? внутри authlogic_rpx
  def validate_password_not_rpx?
    #super
    begin
      ps1 = session_class.controller.params[:user][:password]
    rescue 
      ps1 = ""
    end

    begin
      ps2 = session_class.controller.params[:user][:password_confirmation]
    rescue 
      ps2 = ""
    end

    if (new_record? || (ps1.any? || ps2.any?)) then
      return true
    else 
      return false
    end
  end

  #attr_accessible :login, :email, :password, :password_confirmation, :rpx_identifier 

  def self.find_by_login_or_email(login)
    User.find_by_login(login) || User.find_by_email(login)
  end

  # Используется в Model -> Ability
  def role?(role)
    @roles ||= roles.map(&:name)
    @roles.include? role.to_s
  end

  def deliver_register_complete!
    Notifier.deliver_register_complete(self)
  end

end
