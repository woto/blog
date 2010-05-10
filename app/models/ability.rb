class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :read, :all
    can :create, UserSession
    cannot :destroy, UserSession
    can :create, User
    cannot :destroy, User
    cannot :edit, User
    cannot :read, User

    if user.role? :user
      can :destroy, UserSession
      cannot :create, UserSession
      cannot :create, User
      can :edit, User
      can :read, User
      can :addrpxauth, User
    end
   

    if user.role? :admin
      can :manage, :all
    end

    #can :create, CaptchaTest do |post|
    #  user.email.try(:any?)
    #end

  end
end
