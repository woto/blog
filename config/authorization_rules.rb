authorization do
  role :admin do
    has_permission_on [:posts, :comments], :to => [:index, :show, :new, :create, :edit, :update, :destroy]
  end

  role :guest do
    has_permission_on :posts, :to => [:index, :show]
    has_permission_on :comments do
      if_att
  end

#privileges do
#  privilege :manage do
#    includes :create, :read, :update, :delete
#  end
end
