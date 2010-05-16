class Category < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name

  acts_as_nested_set
  has_many :posts
  
  def lvl
    attributes['lvl']
  end
  #after_save :invalidate_full_tree_cache
  #after_destroy :invalidate_full_tree_cache

  def path_name
    "#{'-' * self.level} #{self.name}"
  end

end
