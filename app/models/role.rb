class Role < ActiveRecord::Base
  has_many :assignments, :dependent => :destroy
  has_many :roles, :through => :assignments
end
