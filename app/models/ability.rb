class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :read, :all
    can :create, UserSession
    can :create, User
    cannot :destroy, UserSession
    cannot :destroy, User
    cannot :update, User
    cannot :read, User
    cannot :destroy, User

    if user.role? :user
      can :destroy, UserSession
      can :update, User
      can :read, User
      can :addrpxauth, User
      can :destroy, User
      cannot :create, UserSession
      cannot :create, User
    end
   
    can :search, Post
    can :calendar, Post

    if user.role? :admin
      can :manage, :all
    end

    can :create, CaptchaTest do |post|
      user.email.try(:any?)
    end
    
  end
end
