class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user

    if user.role? :admin
      can :manage, :all
    end
    
    can :create, CaptchaTest do |post|
      user.email.try(:any?)
      # session[:redirect_to] = '/zzz' unless result
    end

    can :read, :all
    # can :edit, :all
    # can :update, :all
    # can :destroy, :all
  end
end
