class Category < ActiveRecord::Base
  acts_as_nested_set
  validates_presence_of :name
  has_many :posts
  def path_name
    "#{'-' * self.level} #{self.name}"
  end

end
