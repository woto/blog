authorization do
  role :admin do
    has_permission_on :authorization_rules, :to => :manage
  end
end

privileges do
  privilege :manage do
    includes :create, :read, :update, :delete
  end
end